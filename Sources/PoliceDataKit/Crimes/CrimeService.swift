//
//  CrimeService.swift
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
/// Provides an interface for obtaining crime data from the UK Police API.
///
@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12, *)
public final class CrimeService {

    ///
    /// A single, shared crime service object.
    ///
    /// Use this object to interface to crime services in your application.
    ///
    public static let shared = CrimeService()

    private let apiClient: any APIClient
    private let cache: any CrimeCache
    private let availableDataRegion: MKCoordinateRegion

    ///
    /// Creates a crime service object.
    ///
    /// Use this method to create different `CrimeService` instances. If you only need one instance of
    /// `CrimeService`, use ``CrimeService/shared``.
    ///
    public convenience init() {
        self.init(
            apiClient: PoliceDataKitFactory.apiClient,
            cache: PoliceDataKitFactory.crimeCache,
            availableDataRegion: .availableDataRegion
        )
    }

    init(apiClient: some APIClient, cache: some CrimeCache, availableDataRegion: MKCoordinateRegion) {
        self.apiClient = apiClient
        self.cache = cache
        self.availableDataRegion = availableDataRegion
    }

    ///
    /// Returns a list of crimes at street-level within a 1 mile radius of a single point.
    ///
    /// The street-level crimes returned in the API are only an approximation of where the actual crimes occurred, they are not
    /// the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more
    /// information about location anonymisation.
    ///
    /// Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// [https://data.police.uk/docs/method/crime-street/](https://data.police.uk/docs/method/crime-street/)
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Crime data error ``CrimeError``.
    ///
    /// - Returns: The street level crimes in a 1 mile radius of the specifed coordinate and date.
    ///
    public func streetLevelCrimes(at coordinate: CLLocationCoordinate2D, date: Date = Date()) async throws -> [Crime] {
        guard availableDataRegion.contains(coordinate: coordinate) else {
            throw CrimeError.locationOutsideOfDataSetRegion
        }

        let crimes: [Crime]
        do {
            crimes = try await apiClient.get(
                endpoint: CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date)
            )
        } catch let error {
            throw Self.mapToCrimeError(error)
        }

        return crimes
    }

    ///
    /// Returns a publisher that wraps a list of crimes at street-level within a 1 mile radius of a single point.
    ///
    /// The street-level crimes returned in the API are only an approximation of where the actual crimes occurred, they are not
    /// the exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more
    /// information about location anonymisation.
    ///
    /// Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// [https://data.police.uk/docs/method/crime-street/](https://data.police.uk/docs/method/crime-street/)
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: The street level crimes in a 1 mile radius of the specifed coordinate and date.
    ///
    public func streetLevelCrimesPublisher(
        at coordinate: CLLocationCoordinate2D,
        date: Date = Date()
    ) -> AnyPublisher<[Crime], CrimeError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.unknown))
                return
            }

            Task {
                do {
                    let crimes = try await self.streetLevelCrimes(at: coordinate, date: date)
                    promise(.success(crimes))
                } catch let error {
                    let crimeError = Self.mapToCrimeError(error)
                    promise(.failure(crimeError))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    ///
    /// Returns a list of crimes within a custom area.
    ///
    /// The street-level crimes returned in the API are only an approximation of where the actual crimes occurred, they are not the
    /// exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more
    /// information about location anonymisation.
    ///
    /// Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// [https://data.police.uk/docs/method/crime-street/](https://data.police.uk/docs/method/crime-street/)
    ///
    /// - Parameters:
    ///   - coordinates: Coordinates which define the boundary of the custom area.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Crime data error ``CrimeError``.
    ///
    /// - Returns: The street level crimes with the specified area and month..
    ///
    public func streetLevelCrimes(
        in coordinates: [CLLocationCoordinate2D],
        date: Date = Date()
    ) async throws -> [Crime] {
        let crimes: [Crime]
        do {
            crimes = try await apiClient.get(
                endpoint: CrimesEndpoint.streetLevelCrimesInArea(coordinates: coordinates, date: date)
            )
        } catch let error {
            throw Self.mapToCrimeError(error)
        }

        return crimes
    }

    ///
    /// Returns a publisher that wraps a list of crimes within a custom area.
    ///
    /// The street-level crimes returned in the API are only an approximation of where the actual crimes occurred, they are not the
    /// exact locations. See the [about page](https://data.police.uk/about/#location-anonymisation) for more
    /// information about location anonymisation.
    ///
    /// Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// [https://data.police.uk/docs/method/crime-street/](https://data.police.uk/docs/method/crime-street/)
    ///
    /// - Parameters:
    ///   - coordinates: Coordinates which define the boundary of the custom area.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Crime data error ``CrimeError``.
    ///
    /// - Returns: The street level crimes with the specified area and month..
    ///
    public func streetLevelCrimesPublisher(
        in coordinates: [CLLocationCoordinate2D],
        date: Date = Date()
    ) -> AnyPublisher<[Crime], CrimeError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.unknown))
                return
            }

            Task {
                do {
                    let crimes = try await self.streetLevelCrimes(in: coordinates, date: date)
                    promise(.success(crimes))
                } catch let error {
                    let crimeError = Self.mapToCrimeError(error)
                    promise(.failure(crimeError))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    ///
    /// Returns just the crimes which occurred at the specified location, rather than those within a radius.
    ///
    /// Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// [https://data.police.uk/docs/method/crimes-at-location/](https://data.police.uk/docs/method/crimes-at-location/)
    ///
    /// - Parameters:
    ///   - streetID: The street identifier.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Crime data error ``CrimeError``.
    ///
    /// - Returns: The crimes at the specified street and date.
    ///
    public func crimes(forStreet streetID: Int, date: Date = Date()) async throws -> [Crime] {
        if let cachedCrimes = await cache.crimes(forStreet: streetID, date: date) {
            return cachedCrimes
        }

        let crimes: [Crime]
        do {
            crimes = try await apiClient.get(
                endpoint: CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date)
            )
        } catch let error {
            throw Self.mapToCrimeError(error)
        }

        await cache.setCrimes(crimes, forStreet: streetID, date: date)

        return crimes
    }

    ///
    /// Returns just the crimes which occurred at the specified location, rather than those within a radius by finding the nearest location of the coordinate and
    /// the crimes which occurred there.
    ///
    /// Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// [https://data.police.uk/docs/method/crimes-at-location/](https://data.police.uk/docs/method/crimes-at-location/)
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Crime data error ``CrimeError``.
    ///
    /// - Returns: The crimes for the street nearest to the specified coordinate and date.
    ///
    public func crimes(at coordinate: CLLocationCoordinate2D, date: Date = Date()) async throws -> [Crime] {
        guard availableDataRegion.contains(coordinate: coordinate) else {
            throw CrimeError.locationOutsideOfDataSetRegion
        }

        let crimes: [Crime]
        do {
            crimes = try await apiClient.get(
                endpoint: CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date)
            )
        } catch let error {
            throw Self.mapToCrimeError(error)
        }

        return crimes
    }

    ///
    /// Returns a publisher that wraps just the crimes which occurred at the specified location, rather than those within a radius by finding the nearest
    /// location of the coordinate and the crimes which occurred there.
    ///
    /// Since only the British Transport Police provide data for Scotland, crime levels may appear much lower than they really are.
    ///
    /// [https://data.police.uk/docs/method/crimes-at-location/](https://data.police.uk/docs/method/crimes-at-location/)
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Returns: The crimes for the street nearest to the specified coordinate and date.
    ///
    public func crimesPublisher(
        at coordinate: CLLocationCoordinate2D,
        date: Date = Date()
    ) -> AnyPublisher<[Crime], CrimeError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.unknown))
                return
            }

            Task {
                do {
                    let crimes = try await self.crimes(at: coordinate, date: date)
                    promise(.success(crimes))
                } catch let error {
                    let crimeError = Self.mapToCrimeError(error)
                    promise(.failure(crimeError))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    ///
    /// Returns a list of crimes that could not be mapped to a location.
    ///
    /// [https://data.police.uk/docs/method/crimes-no-location/](https://data.police.uk/docs/method/crimes-no-location/)
    ///
    /// - Parameters:
    ///   - category: The category of the crimes. All crimes with be shown by default.
    ///   - policeForceID: Police Force identifier.
    ///   - date: Limit results to a specific month. The latest month will be shown by default.
    ///
    /// - Throws: Crime data error ``CrimeError``.
    ///
    /// - Returns: The crimes not mapped to a location.
    ///
    public func crimesWithNoLocation(
        forCategory categoryID: CrimeCategory.ID = CrimeCategory.default.id,
        inPoliceForce policeForceID: PoliceForce.ID,
        date: Date = Date()
    ) async throws -> [Crime] {
        if let cachedCrimes = await cache.crimesWithNoLocation(
            forCategory: categoryID,
            inPoliceForce: policeForceID,
            date: date
        ) {
            return cachedCrimes
        }

        let crimes: [Crime]
        do {
            crimes = try await apiClient.get(
                endpoint: CrimesEndpoint.crimesWithNoLocation(
                    categoryID: categoryID, policeForceID: policeForceID, date: date
                )
            )
        } catch let error {
            throw Self.mapToCrimeError(error)
        }

        await cache.setCrimesWithNoLocation(crimes, forCategory: categoryID, inPoliceForce: policeForceID, date: date)

        return crimes
    }

    ///
    /// Returns a list of valid crime categories for a given data set date.
    ///
    /// [https://data.police.uk/docs/method/crime-categories/](https://data.police.uk/docs/method/crime-categories/)
    ///
    /// - Parameter date: Month to fetch crime categories for. The latest month will be shown by default.
    ///
    /// - Throws: Crime data error ``CrimeError``.
    ///
    /// - Returns: The crime categories for the specified month.
    ///
    public func crimeCategories(forDate date: Date = Date()) async throws -> [CrimeCategory] {
        if let cachedCategories = await cache.crimeCategories(forDate: date) {
            return cachedCategories
        }

        let crimeCategories: [CrimeCategory]
        do {
            crimeCategories = try await apiClient.get(endpoint: CrimesEndpoint.categories(date: date))
        } catch let error {
            throw Self.mapToCrimeError(error)
        }

        await cache.setCrimeCategories(crimeCategories, forDate: date)

        return crimeCategories
    }

}

extension CrimeService {

    private static func mapToCrimeError(_ error: Error) -> CrimeError {
        if let error = error as? CrimeError {
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
