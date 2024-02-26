//
//  NeighbourhoodService.swift
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
/// Provides an interface for obtaining neighbourhood data from the UK Police API.
///
@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12, *)
public final class NeighbourhoodService {

    ///
    /// A single, shared neighbourhood service object.
    ///
    /// Use this object to interface to neighbourhood services in your application.
    ///
    public static let shared = NeighbourhoodService()

    private let apiClient: any APIClient
    private let cache: any NeighbourhoodCache
    private let availableDataRegion: MKCoordinateRegion

    ///
    /// Creates a neighbourhood service object.
    ///
    /// Use this method to create different `NeighbourhoodService` instances. If you only need one instance of
    /// `NeighbourhoodService`, use `shared`.
    ///
    public convenience init() {
        self.init(
            apiClient: PoliceDataKitFactory.apiClient,
            cache: PoliceDataKitFactory.neighbourhoodCache,
            availableDataRegion: .availableDataRegion
        )
    }

    init(apiClient: some APIClient, cache: some NeighbourhoodCache, availableDataRegion: MKCoordinateRegion) {
        self.apiClient = apiClient
        self.cache = cache
        self.availableDataRegion = availableDataRegion
    }

    ///
    /// Returns a list of all the neighbourhoods in a police force.
    ///
    /// [https://data.police.uk/docs/method/neighbourhoods/](https://data.police.uk/docs/method/neighbourhoods/)
    ///
    /// - Parameter policeForceID: Police force identifier.
    ///
    /// - Throws: Neighbourhood data error ``NeighbourhoodError``.
    ///
    /// - Returns: The neighbourhoods in the specified police force.
    ///
    public func neighbourhoods(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [NeighbourhoodReference] {
        if let cachedNeighbourhoodReferences = await cache.neighbourhoods(inPoliceForce: policeForceID) {
            return cachedNeighbourhoodReferences
        }

        let neighbourhoodReferences: [NeighbourhoodReference]
        do {
            neighbourhoodReferences = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.list(policeForceID: policeForceID)
            )
        } catch let error {
            throw Self.mapToNeighbourhoodError(error)
        }

        await cache.setNeighbourhoods(neighbourhoodReferences, inPoliceForce: policeForceID)

        return neighbourhoodReferences
    }

    ///
    /// Returns details of a neighbourhood in a police force.
    ///
    /// [https://data.police.uk/docs/method/neighbourhood/](https://data.police.uk/docs/method/neighbourhood/)
    ///
    /// - Parameters:
    ///   - id: Neighbourhood identifier.
    ///   - policeForceID: Police Force identifier.
    ///
    /// - Throws: Neighbourhood data error ``NeighbourhoodError``.
    ///
    /// - Returns: The neighbourhood matching the specified ID and police force.
    ///
    public func neighbourhood(
        withID id: String,
        inPoliceForce policeForceID: PoliceForce.ID
    ) async throws -> Neighbourhood {
        if let cachedNeighbourhood = await cache.neighbourhood(withID: id, inPoliceForce: policeForceID) {
            return cachedNeighbourhood
        }

        let neighbourhood: Neighbourhood
        do {
            neighbourhood = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID)
            )
        } catch let error {
            throw Self.mapToNeighbourhoodError(error)
        }

        await cache.setNeighbourhood(neighbourhood, withID: id, inPoliceForce: policeForceID)

        return neighbourhood
    }

    ///
    /// Returns details of a neighbourhood at a specific coordinate.
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///
    /// - Throws: Neighbourhood data error ``NeighbourhoodError``.
    ///
    /// - Returns: The neighbourhood at the specified coordinate.
    ///
    public func neighbourhood(at coordinate: CLLocationCoordinate2D) async throws -> Neighbourhood {
        let neighbourhoodPolicingTeam = try await neighbourhoodPolicingTeam(at: coordinate)
        let neighbourhood = try await neighbourhood(
            withID: neighbourhoodPolicingTeam.neighbourhood,
            inPoliceForce: neighbourhoodPolicingTeam.force
        )

        return neighbourhood
    }

    ///
    /// Returns a publisher that wraps a neighbourhood for the specified location.
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///
    /// - Returns: The neighbourhood at the specified coordinate.
    ///
    public func neighbourhoodPublisher(
        at coordinate: CLLocationCoordinate2D
    ) -> AnyPublisher<Neighbourhood, NeighbourhoodError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.unknown))
                return
            }

            Task {
                do {
                    let neighbourhood = try await self.neighbourhood(at: coordinate)
                    promise(.success(neighbourhood))
                } catch let error {
                    let neighbourhoodError = Self.mapToNeighbourhoodError(error)
                    promise(.failure(neighbourhoodError))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    ///
    /// Returns a list of coordinates that make up the boundary of a neighbourhood.
    ///
    /// [https://data.police.uk/docs/method/neighbourhood-boundary/](https://data.police.uk/docs/method/neighbourhood-boundary/)
    ///
    /// - Parameters:
    ///   - neighbourhoodID: Neighbourhood identifier.
    ///   - policeForceID: Police Force identifier.
    ///
    /// - Throws: Neighbourhood data error ``NeighbourhoodError``.
    ///
    /// - Returns: The coordinates that make up the boundary of the matching neighbourhood.
    ///
    public func boundary(
        forNeighbourhood neighbourhoodID: Neighbourhood.ID,
        inPoliceForce policeForceID: PoliceForce.ID
    ) async throws -> [CLLocationCoordinate2D] {
        if let cachedBoundary = await cache.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID) {
            return cachedBoundary
        }

        let boundary: [CLLocationCoordinate2D]
        do {
            boundary = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.boundary(
                    neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
                )
            )
        } catch let error {
            throw Self.mapToNeighbourhoodError(error)
        }

        await cache.setBoundary(boundary, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        return boundary
    }

    ///
    /// Returns a list of Police Officers who are members of the neighbourhood team for a neighbourhood.
    ///
    /// [https://data.police.uk/docs/method/neighbourhood-team/](https://data.police.uk/docs/method/neighbourhood-team/)
    ///
    /// - Parameters:
    ///   - neighbourhoodID: Neighbourhood identifier.
    ///   - policeForceID: Police Force identifier.
    ///
    /// - Throws: Neighbourhood data error ``NeighbourhoodError``.
    ///
    /// - Returns: Police officers who are members of the neighbourhood team for the specified neighbourhood and police force.
    ///
    public func policeOfficers(
        forNeighbourhood neighbourhoodID: Neighbourhood.ID,
        inPoliceForce policeForceID: PoliceForce.ID
    ) async throws -> [PoliceOfficer] {
        if let cachedPoliceOfficers = await cache.policeOfficers(
            forNeighbourhood: neighbourhoodID,
            inPoliceForce: policeForceID
        ) {
            return cachedPoliceOfficers
        }

        let policeOfficers: [PoliceOfficer]
        do {
            policeOfficers = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.policeOfficers(
                    neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
                )
            )
        } catch let error {
            throw Self.mapToNeighbourhoodError(error)
        }

        await cache.setPoliceOfficers(policeOfficers, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        return policeOfficers
    }

    ///
    /// Returns a list of priorities for a neighbourhood.
    ///
    /// [https://data.police.uk/docs/method/neighbourhood-priorities/](https://data.police.uk/docs/method/neighbourhood-priorities/)
    ///
    /// - Parameters:
    ///   - neighbourhoodID: Neighbourhood identifier.
    ///   - policeForceID: Police Force identifier.
    ///
    /// - Throws: Neighbourhood data error ``NeighbourhoodError``.
    ///
    /// - Returns: The neighbourhood priorities for the specified neighbourhood and police force.
    ///
    public func priorities(
        forNeighbourhood neighbourhoodID: Neighbourhood.ID,
        inPoliceForce policeForceID: PoliceForce.ID
    ) async throws -> [NeighbourhoodPriority] {
        if let cachedPriorities = await cache.priorities(
            forNeighbourhood: neighbourhoodID,
            inPoliceForce: policeForceID
        ) {
            return cachedPriorities
        }

        let priorities: [NeighbourhoodPriority]
        do {
            priorities = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.priorities(
                    neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
                )
            )
        } catch let error {
            throw Self.mapToNeighbourhoodError(error)
        }

        await cache.setPriorities(priorities, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        return priorities
    }

    ///
    /// Returns the neighbourhood policing team responsible for a particular area.
    ///
    /// [https://data.police.uk/docs/method/neighbourhood-locate/](https://data.police.uk/docs/method/neighbourhood-locate/)
    ///
    /// - Parameter coordinate: A coordinate.
    ///
    /// - Throws: Neighbourhood data error ``NeighbourhoodError``.
    ///
    /// - Returns: The neighbourhood policing team for the specificed location.
    ///
    public func neighbourhoodPolicingTeam(
        at coordinate: CLLocationCoordinate2D
    ) async throws -> NeighbourhoodPolicingTeam {
        guard availableDataRegion.contains(coordinate: coordinate) else {
            throw NeighbourhoodError.locationOutsideOfDataSetRegion
        }

        let policingTeam: NeighbourhoodPolicingTeam
        do {
            policingTeam = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate)
            )
        } catch let error {
            throw Self.mapToNeighbourhoodError(error)
        }

        return policingTeam
    }

    ///
    /// Returns a publisher that wraps a neighbourhood policing team responsible for a particular area.
    ///
    /// [https://data.police.uk/docs/method/neighbourhood-locate/](https://data.police.uk/docs/method/neighbourhood-locate/)
    ///
    /// - Parameter coordinate: A coordinate.
    ///
    /// - Returns: The neighbourhood policing team for the specificed location.
    ///
    public func neighbourhoodPolicingTeamPublisher(
        at coordinate: CLLocationCoordinate2D
    ) -> AnyPublisher<NeighbourhoodPolicingTeam, NeighbourhoodError> {
        Future { [weak self] promise in
            guard let self else {
                promise(.failure(.unknown))
                return
            }

            Task {
                do {
                    let policingTeam = try await self.neighbourhoodPolicingTeam(at: coordinate)
                    promise(.success(policingTeam))
                } catch let error {
                    let neighbourhoodError = Self.mapToNeighbourhoodError(error)
                    promise(.failure(neighbourhoodError))
                }
            }
        }
        .eraseToAnyPublisher()
    }

}

extension NeighbourhoodService {

    private static func mapToNeighbourhoodError(_ error: Error) -> NeighbourhoodError {
        if let error = error as? NeighbourhoodError {
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
