//
//  StopAndSearchService.swift
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

import Combine
import Foundation
import MapKit

///
/// Provides an interface for obtaining stop and search data from the UK Police API.
///
/// The data published is provided by police forces on a monthly basis. The data submitted goes through
/// validation to check for mandatory fields and data formats. The location coordinates of the stop are anonymised
/// and the age of the person stopped is changed to an age group (e.g. 18-24) before publication.
///
@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12, *)
public final class StopAndSearchService {

    ///
    /// A single, shared stop and search service object.
    ///
    /// Use this object to interface to stop and search services in your application.
    ///
    public static let shared = StopAndSearchService()

    private let apiClient: any APIClient
    private let cache: any StopAndSearchCache
    private let availableDataRegion: MKCoordinateRegion

    ///
    /// Creates a stop and search service object.
    ///
    /// Use this method to create different `StopAndSearchService` instances. If you only need one instance of
    /// `StopAndSearchService`, use `shared`.
    ///
    public convenience init() {
        self.init(
            apiClient: PoliceDataKitFactory.apiClient,
            cache: PoliceDataKitFactory.stopAndSearchCache,
            availableDataRegion: .availableDataRegion
        )
    }

    init(apiClient: some APIClient, cache: some StopAndSearchCache, availableDataRegion: MKCoordinateRegion) {
        self.apiClient = apiClient
        self.cache = cache
        self.availableDataRegion = availableDataRegion
    }

    ///
    /// Returns stop and searches at street-level within a 1 mile radius of a single point.
    ///
    /// The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches
    /// occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation)
    /// for more information about location anonymisation.
    ///
    /// [https://data.police.uk/docs/method/stops-street/](https://data.police.uk/docs/method/stops-street/)
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Stop and Search data error ``StopAndSearchError``.
    ///
    /// - Returns: A list of stop and searches.
    ///
    public func stopAndSearches(
        at coordinate: CLLocationCoordinate2D,
        date: Date = Date()
    ) async throws -> [StopAndSearch] {
        guard availableDataRegion.contains(coordinate: coordinate) else {
            throw StopAndSearchError.locationOutsideOfDataSetRegion
        }

        let stopAndSearches: [StopAndSearch]
        do {
            stopAndSearches = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(
                    coordinate: coordinate, date: date
                )
            )
        } catch let error {
            throw Self.mapToStopAndSearchError(error)
        }

        return stopAndSearches
    }

    ///
    /// Returns a publisher that wraps stop and searches at street-level within a 1 mile radius of a single point.
    ///
    /// The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches
    /// occurred, they are not the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation)
    /// for more information about location anonymisation.
    ///
    /// [https://data.police.uk/docs/method/stops-street/](https://data.police.uk/docs/method/stops-street/)
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of stop and searches.
    ///
    public func stopAndSearchesPublisher(
        at coordinate: CLLocationCoordinate2D,
        date: Date = Date()
    ) -> AnyPublisher<[StopAndSearch], StopAndSearchError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.unknown))
                return
            }

            Task {
                do {
                    let stopAndSearches = try await self.stopAndSearches(at: coordinate, date: date)
                    promise(.success(stopAndSearches))
                } catch let error {
                    let outcomeError = Self.mapToStopAndSearchError(error)
                    promise(.failure(outcomeError))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    ///
    /// Returns stop and searches at street-level within a custom area.
    ///
    /// The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the
    /// exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about
    /// location anonymisation.
    ///
    /// [https://data.police.uk/docs/method/stops-street/](https://data.police.uk/docs/method/stops-street/)
    ///
    /// - Parameters:
    ///   - coordinates: Coordinates which define the boundary of the custom area.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Stop and Search data error ``StopAndSearchError``.
    ///
    /// - Returns: A list of stop and searches.
    ///
    public func stopAndSearches(
        in coordinates: [CLLocationCoordinate2D],
        date: Date = Date()
    ) async throws -> [StopAndSearch] {
        let stopAndSearches: [StopAndSearch]
        do {
            stopAndSearches = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates, date: date)
            )
        } catch let error {
            throw Self.mapToStopAndSearchError(error)
        }

        return stopAndSearches
    }

    ///
    /// Returns a publisher that wraps  stop and searches at street-level within a custom area.
    ///
    /// The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the
    /// exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about
    /// location anonymisation.
    ///
    /// [https://data.police.uk/docs/method/stops-street/](https://data.police.uk/docs/method/stops-street/)
    ///
    /// - Parameters:
    ///   - coordinates: Coordinates which define the boundary of the custom area.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: A list of stop and searches.
    ///
    public func stopAndSearchesPublisher(
        in coordinates: [CLLocationCoordinate2D],
        date: Date = Date()
    ) -> AnyPublisher<[StopAndSearch], StopAndSearchError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.unknown))
                return
            }

            Task {
                do {
                    let stopAndSearches = try await self.stopAndSearches(in: coordinates, date: date)
                    promise(.success(stopAndSearches))
                } catch let error {
                    let outcomeError = Self.mapToStopAndSearchError(error)
                    promise(.failure(outcomeError))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    ///
    /// Returns stop and searches at a particular location.
    ///
    /// The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the
    /// exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about
    /// location anonymisation.
    ///
    /// [https://data.police.uk/docs/method/stops-at-location/](https://data.police.uk/docs/method/stops-at-location/)
    ///
    /// - Parameters:
    ///   - streetID: A street ID.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Stop and Search data error ``StopAndSearchError``.
    ///
    /// - Returns: A list of stop and searches.
    ///
    public func stopAndSearches(atLocation streetID: Int, date: Date = Date()) async throws -> [StopAndSearch] {
        if let cachedStopAndSearches = await cache.stopAndSearches(atLocation: streetID, date: date) {
            return cachedStopAndSearches
        }

        let stopAndSearches: [StopAndSearch]
        do {
            stopAndSearches = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date)
            )
        } catch let error {
            throw Self.mapToStopAndSearchError(error)
        }

        await cache.setStopAndSearches(stopAndSearches, atLocation: streetID, date: date)

        return stopAndSearches
    }

    ///
    /// Returns stop and searches that could not be mapped to a location.
    ///
    /// The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the
    /// exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about
    /// location anonymisation.
    ///
    /// [https://data.police.uk/docs/method/stops-no-location/](https://data.police.uk/docs/method/stops-no-location/)
    ///
    /// - Parameters:
    ///   - policeForceID: Police Force identifier.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Stop and Search data error ``StopAndSearchError``.
    ///
    /// - Returns: A list of stop and searches.
    ///
    public func stopAndSearchesWithNoLocation(
        forPoliceForce policeForceID: PoliceForce.ID,
        date: Date = Date()
    ) async throws -> [StopAndSearch] {
        if let cachedStopAndSearches = await cache.stopAndSearchesWithNoLocation(
            forPoliceForce: policeForceID,
            date: date
        ) {
            return cachedStopAndSearches
        }

        let stopAndSearches: [StopAndSearch]
        do {
            stopAndSearches = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(
                    policeForceID: policeForceID, date: date
                )
            )
        } catch let error {
            throw Self.mapToStopAndSearchError(error)
        }

        await cache.setStopAndSearchesWithNoLocation(stopAndSearches, forPoliceForce: policeForceID, date: date)

        return stopAndSearches
    }

    ///
    /// Returns stop and searches reported by a particular force.
    ///
    /// The stop and searches returned in the API, like the crimes, are only an approximation of where the actual stop and searches occurred, they are not the
    /// exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more information about
    /// location anonymisation.
    ///
    /// [https://data.police.uk/docs/method/stops-force/](https://data.police.uk/docs/method/stops-force/)
    ///
    /// - Parameters:
    ///   - policeForceID: Police Force identifier.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Stop and Search data error ``StopAndSearchError``.
    ///
    /// - Returns: A list of stop and searches.
    ///
    public func stopAndSearches(
        forPoliceForce policeForceID: PoliceForce.ID,
        date: Date = Date()
    ) async throws -> [StopAndSearch] {
        if let cachedStopAndSearches = await cache.stopAndSearches(forPoliceForce: policeForceID, date: date) {
            return cachedStopAndSearches
        }

        let stopAndSearches: [StopAndSearch]
        do {
            stopAndSearches = try await apiClient.get(
                endpoint: StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID, date: date)
            )
        } catch let error {
            throw Self.mapToStopAndSearchError(error)
        }

        await cache.setStopAndSearches(stopAndSearches, forPoliceForce: policeForceID, date: date)

        return stopAndSearches
    }

}

extension StopAndSearchService {

    private static func mapToStopAndSearchError(_ error: Error) -> StopAndSearchError {
        if let error = error as? StopAndSearchError {
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
