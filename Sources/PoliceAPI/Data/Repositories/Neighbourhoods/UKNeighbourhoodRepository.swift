import Foundation
import os

final class UKNeighbourhoodRepository: NeighbourhoodRepository {

    private static let logger = Logger(subsystem: Logger.dataSubsystem, category: "UKNeighbourhoodRepository")

    private let apiClient: any APIClient
    private let cache: any Cache
    private let availableDataRegion: CoordinateRegionDataModel

    init(apiClient: some APIClient, cache: some Cache, availableDataRegion: CoordinateRegionDataModel) {
        self.apiClient = apiClient
        self.cache = cache
        self.availableDataRegion = availableDataRegion
    }

    func neighbourhoods(inPoliceForce policeForceID: PoliceForceDataModel.ID) async throws -> [NeighbourhoodReferenceDataModel] {
        Self.logger.trace("fetching Neighbourhoods in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)
        if let cachedNeighbourhoods = await cache.object(for: cacheKey, type: [NeighbourhoodReferenceDataModel].self) {
            return cachedNeighbourhoods
        }

        let neighbourhoods: [NeighbourhoodReferenceDataModel]

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

    func neighbourhood(withID id: String, inPoliceForce policeForceID: String) async throws -> NeighbourhoodDataModel? {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Neighbourhood \(id, privacy: .public) in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodCachingKey(id: id, policeForceID: policeForceID)
        if let cachedNeighbourhood = await cache.object(for: cacheKey, type: NeighbourhoodDataModel.self) {
            return cachedNeighbourhood
        }

        let neighbourhood: NeighbourhoodDataModel

        do {
            neighbourhood = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID)
            )
        } catch let error {
            switch error as? PoliceDataError {
            case .notFound:
                return nil

            default:
                break
            }

            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Neighbourhood \(id, privacy: .public) in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        await cache.set(neighbourhood, for: cacheKey)

        return neighbourhood
    }

    func boundary(forNeighbourhood neighbourhoodID: NeighbourhoodDataModel.ID,
                  inPoliceForce policeForceID: PoliceForceDataModel.ID) async throws -> BoundaryDataModel? {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Boundary for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        if let cachedBoundary = await cache.object(for: cacheKey, type: BoundaryDataModel.self) {
            return cachedBoundary
        }

        let boundary: BoundaryDataModel
        do {
            boundary = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.boundary(
                    neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
                )
            )
        } catch let error {
            switch error as? PoliceDataError {
            case .notFound:
                return nil

            default:
                break
            }

            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Boundary for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        await cache.set(boundary, for: cacheKey)

        return boundary
    }

    func policeOfficers(forNeighbourhood neighbourhoodID: NeighbourhoodDataModel.ID,
                        inPoliceForce policeForceID: PoliceForceDataModel.ID) async throws -> [PoliceOfficerDataModel] {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Police Officers for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodPoliceOfficersCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )
        if let cachedPoliceOfficers = await cache.object(for: cacheKey, type: [PoliceOfficerDataModel].self) {
            return cachedPoliceOfficers
        }

        let policeOfficers: [PoliceOfficerDataModel]
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

    func priorities(forNeighbourhood neighbourhoodID: NeighbourhoodDataModel.ID,
                    inPoliceForce policeForceID: PoliceForceDataModel.ID) async throws -> [NeighbourhoodPriorityDataModel] {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Priorities for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodPrioritiesCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )
        if let cachedPriorities = await cache.object(for: cacheKey, type: [NeighbourhoodPriorityDataModel].self) {
            return cachedPriorities
        }

        let priorities: [NeighbourhoodPriorityDataModel]
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

    func neighbourhoodPolicingTeam(atCoordinate coordinate: CoordinateDataModel) async throws -> NeighbourhoodPolicingTeamDataModel? {
        Self.logger.trace("fetching Neighbourhood Policing Team at coordinate \(coordinate, privacy: .public)")

        guard availableDataRegion.contains(coordinate: coordinate) else {
            return nil
        }

        let policingTeam: NeighbourhoodPolicingTeamDataModel
        do {
            policingTeam = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate)
            )
        } catch let error {
            switch error as? PoliceDataError {
            case .notFound:
                return nil
            default:
                break
            }

            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Neighbourhood Policing Team at coordinate \(coordinate, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        return policingTeam
    }

}
