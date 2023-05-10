import Foundation
import MapKit
import os

///
/// Provides an interface for obtaining neighbourhood data from the UK Police API.
///
public final class NeighbourhoodService {

    ///
    /// A single, shared neighbourhood service object.
    ///
    /// Use this object to interface to neighbourhood services in your application.
    ///
    public static let shared = NeighbourhoodService()

    private static let logger = Logger(subsystem: Logger.policeDataKit, category: "NeighbourhoodService")

    private let apiClient: any APIClient
    private let cache: any Cache
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
            cache: PoliceDataKitFactory.cache,
            availableDataRegion: .availableDataRegion
        )
    }

    init(apiClient: some APIClient, cache: some Cache, availableDataRegion: MKCoordinateRegion) {
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
        Self.logger.trace("fetching Neighbourhoods in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)
        if let cachedNeighbourhoodReferences = await cache.object(for: cacheKey, type: [NeighbourhoodReference].self) {
            return cachedNeighbourhoodReferences
        }

        let neighbourhoodReferences: [NeighbourhoodReference]
        do {
            neighbourhoodReferences = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.list(policeForceID: policeForceID)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Neighbourhoods in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToNeighbourhoodError(error)
        }

        await cache.set(neighbourhoodReferences, for: cacheKey)

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
    public func neighbourhood(withID id: String,
                              inPoliceForce policeForceID: PoliceForce.ID) async throws -> Neighbourhood {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Neighbourhood \(id, privacy: .public) in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodCachingKey(id: id, policeForceID: policeForceID)
        if let cachedNeighbourhood = await cache.object(for: cacheKey, type: Neighbourhood.self) {
            return cachedNeighbourhood
        }

        let neighbourhood: Neighbourhood
        do {
            neighbourhood = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Neighbourhood \(id, privacy: .public) in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToNeighbourhoodError(error)
        }

        await cache.set(neighbourhood, for: cacheKey)

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
        Self.logger.trace("fetching Neighbourhood at coordinate \(coordinate, privacy: .public)")

        let neighbourhoodPolicingTeam = try await neighbourhoodPolicingTeam(at: coordinate)
        let neighbourhood = try await neighbourhood(
            withID: neighbourhoodPolicingTeam.neighbourhood,
            inPoliceForce: neighbourhoodPolicingTeam.force
        )

        return neighbourhood
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
    public func boundary(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                         inPoliceForce policeForceID: PoliceForce.ID) async throws -> [CLLocationCoordinate2D] {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Boundary for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        if let cachedBoundary = await cache.object(for: cacheKey, type: [CLLocationCoordinate2D].self) {
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
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Boundary for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToNeighbourhoodError(error)
        }

        await cache.set(boundary, for: cacheKey)

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
    public func policeOfficers(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                               inPoliceForce policeForceID: PoliceForce.ID) async throws -> [PoliceOfficer] {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Police Officers for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodPoliceOfficersCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )
        if let cachedPoliceOfficers = await cache.object(for: cacheKey, type: [PoliceOfficer].self) {
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
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Police Officers for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToNeighbourhoodError(error)
        }

        await cache.set(policeOfficers, for: cacheKey)

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
    public func priorities(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                           inPoliceForce policeForceID: PoliceForce.ID) async throws -> [NeighbourhoodPriority] {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Priorities for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodPrioritiesCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )
        if let cachedPriorities = await cache.object(for: cacheKey, type: [NeighbourhoodPriority].self) {
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
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Priorities for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToNeighbourhoodError(error)
        }

        await cache.set(priorities, for: cacheKey)

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
    /// - Returns: The neighbourhood policing team the specificed location.
    ///
    public func neighbourhoodPolicingTeam(
        at coordinate: CLLocationCoordinate2D
    ) async throws -> NeighbourhoodPolicingTeam {
        Self.logger.trace("fetching Neighbourhood Policing Team at coordinate \(coordinate, privacy: .public)")

        guard availableDataRegion.contains(coordinate: coordinate) else {
            throw NeighbourhoodError.locationOutsideOfDataSetRegion
        }

        let policingTeam: NeighbourhoodPolicingTeam
        do {
            policingTeam = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Neighbourhood Policing Team at coordinate \(coordinate, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw Self.mapToNeighbourhoodError(error)
        }

        return policingTeam
    }

}

extension NeighbourhoodService {

    private static func mapToNeighbourhoodError(_ error: Error) -> NeighbourhoodError {
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
