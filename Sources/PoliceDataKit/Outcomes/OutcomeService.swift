//
//  OutcomeService.swift
//  PoliceDataKit
//
//  Copyright © 2024 Adam Young.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an AS IS BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import CoreLocation
import Foundation

///
/// Provides an interface for obtaining outcome data from the UK Police API.
///
public final class OutcomeService: Sendable {

    ///
    /// A single, shared outcome service object.
    ///
    /// Use this object to interface to outcome services in your application.
    ///
    public static let shared = OutcomeService()

    private let apiClient: any APIClient & Sendable
    private let cache: any OutcomeCache & Sendable
    private let availableDataRegion: AvailableRegion

    ///
    /// Creates an outcome service object.
    ///
    /// Use this method to create different `OutcomeService` instances. If you only need one instance of
    /// `OutcomeService`, use `shared`.
    ///
    public convenience init() {
        self.init(
            apiClient: PoliceDataKitFactory.apiClient,
            cache: PoliceDataKitFactory.outcomeCache,
            availableDataRegion: .availableDataRegion
        )
    }

    init(
        apiClient: some APIClient & Sendable,
        cache: some OutcomeCache & Sendable,
        availableDataRegion: AvailableRegion
    ) {
        self.apiClient = apiClient
        self.cache = cache
        self.availableDataRegion = availableDataRegion
    }

    ///
    /// Returns a list of crime outcomes at a specific location.
    ///
    /// [https://data.police.uk/docs/method/outcomes-at-location/](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///   - streetID: Street identifier.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Outcome data error ``OutcomeError``.
    ///
    /// - Returns: The outcomes of crimes for the specified street and date..
    ///
    public func streetLevelOutcomes(forStreet streetID: Int, date: Date = Date()) async throws -> [Outcome] {
        if let cachedOutcomes = await cache.streetLevelOutcomes(forStreet: streetID, date: date) {
            return cachedOutcomes
        }

        let outcomes: [Outcome]
        do {
            outcomes = try await apiClient.get(
                endpoint: OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date)
            )
        } catch let error {
            throw Self.mapToOutcomeError(error)
        }

        await cache.setStreetLevelOutcomes(outcomes, forStreet: streetID, date: date)

        return outcomes
    }

    ///
    /// Returns a list of crime outcomes within a 1 mile radius of a single point.
    ///
    /// [https://data.police.uk/docs/method/outcomes-at-location/](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Outcome data error ``OutcomeError``.
    ///
    /// - Returns: The outcomes of crimes in a 1 mile radius of the specified coordinate and date.
    ///
    public func streetLevelOutcomes(
        at coordinate: CLLocationCoordinate2D,
        date: Date = Date()
    ) async throws -> [Outcome] {
        guard availableDataRegion.contains(coordinate: coordinate) else {
            throw OutcomeError.locationOutsideOfDataSetRegion
        }

        let outcomes: [Outcome]
        do {
            outcomes = try await apiClient.get(
                endpoint: OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date)
            )
        } catch let error {
            throw Self.mapToOutcomeError(error)
        }

        return outcomes
    }

    ///
    /// Returns a list of crime outcomes within a custom area.
    ///
    /// [https://data.police.uk/docs/method/outcomes-at-location/](https://data.police.uk/docs/method/outcomes-at-location/)
    ///
    /// Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameters:
    ///   - coordinates: Coordinates which define the boundary of the custom area.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    ///   - Throws: Outcome data error ``OutcomeError``.
    ///
    /// - Returns: The outcomes of crimes within the specified area.
    ///
    public func streetLevelOutcomes(
        in coordinates: [CLLocationCoordinate2D],
        date: Date = Date()
    ) async throws -> [Outcome] {
        let outcomes: [Outcome]
        do {
            outcomes = try await apiClient.get(
                endpoint: OutcomesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date)
            )
        } catch let error {
            throw Self.mapToOutcomeError(error)
        }

        return outcomes
    }

    ///
    /// Returns the case history for a crime.
    ///
    /// [https://data.police.uk/docs/method/outcomes-for-crime/](https://data.police.uk/docs/method/outcomes-for-crime/)
    ///
    /// Outcomes are not available for the Police Service of Northern Ireland.
    ///
    /// - Parameter crimeID: The crimeID of a crime, not the id.
    ///
    /// - Throws: Outcome data error ``OutcomeError``.
    ///
    /// - Returns: The case history for the specified crime.
    ///
    public func caseHistory(forCrime crimeID: String) async throws -> CaseHistory {
        if let cachedCaseHistory = await cache.caseHistory(forCrime: crimeID) {
            return cachedCaseHistory
        }

        let caseHistory: CaseHistory
        do {
            caseHistory = try await apiClient.get(endpoint: OutcomesEndpoint.caseHistory(crimeID: crimeID))
        } catch let error {
            throw Self.mapToOutcomeError(error)
        }

        await cache.setCaseHistory(caseHistory, forCrime: crimeID)

        return caseHistory
    }

}

extension OutcomeService {

    private static func mapToOutcomeError(_ error: Error) -> OutcomeError {
        if let error = error as? OutcomeError {
            return error
        }

        guard let error = error as? APIClientError else {
            return .unknown
        }

        switch error {
        case .network:
            return .network(error)

        case .notFound:
            return .notFound

        case .decode, .unknown:
            return .unknown
        }
    }

}
