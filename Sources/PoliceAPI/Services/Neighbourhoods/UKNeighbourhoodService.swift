import Foundation
import os

final class UKNeighbourhoodService: NeighbourhoodService {

    private static let logger = Logger(subsystem: Logger.subsystem, category: "NeighbourhoodService")

    private let apiClient: any APIClient
    private let cache: any Cache

    init(apiClient: some APIClient, cache: some Cache) {
        self.apiClient = apiClient
        self.cache = cache
    }

    func neighbourhoods(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [NeighbourhoodReference] {
        Self.logger.trace("fetching Neighbourhoods in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)
        if let cachedNeighbourhoods = await cache.object(for: cacheKey, type: [NeighbourhoodReference].self) {
            return cachedNeighbourhoods
        }

        let neighbourhoods: [NeighbourhoodReference]

        do {
            neighbourhoods = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.list(policeForceID: policeForceID)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Neighbourhoods in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        await cache.set(neighbourhoods, for: cacheKey)

        return neighbourhoods
    }

    func neighbourhood(withID id: String, inPoliceForce policeForceID: String) async throws -> Neighbourhood {
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
            throw error
        }

        await cache.set(neighbourhood, for: cacheKey)

        return neighbourhood
    }

    func boundary(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                  inPoliceForce policeForceID: PoliceForce.ID) async throws -> Boundary {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Boundary for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        if let cachedBoundary = await cache.object(for: cacheKey, type: Boundary.self) {
            return cachedBoundary
        }

        let boundary: Boundary
        do {
            boundary = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.boundary(
                    neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
                )
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Boundary for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        await cache.set(boundary, for: cacheKey)

        return boundary
    }

    func policeOfficers(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
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
            throw error
        }

        await cache.set(policeOfficers, for: cacheKey)

        return policeOfficers
    }

    func priorities(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
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
            throw error
        }

        await cache.set(priorities, for: cacheKey)

        return priorities
    }

    func neighbourhoodPolicingTeam(atCoordinate coordinate: Coordinate) async throws -> NeighbourhoodPolicingTeam {
        Self.logger.trace("fetching Neighbourhood Policing Team at coordinate \(coordinate, privacy: .public)")

        let policingTeam: NeighbourhoodPolicingTeam
        do {
            policingTeam = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Neighbourhood Policing Team at coordinate \(coordinate, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return policingTeam
    }

}
