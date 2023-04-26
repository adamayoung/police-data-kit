import CoreLocation
import Foundation
import os

final class UKNeighbourhoodRepository: NeighbourhoodRepository {

    private static let logger = Logger(subsystem: Logger.dataSubsystem, category: "UKNeighbourhoodRepository")

    private let apiClient: any APIClient
    private let cache: any Cache
    private let availableDataRegion: CoordinateRegionDataModel

    convenience init(apiClient: some APIClient, cache: some Cache) {
        self.init(apiClient: apiClient, cache: cache, availableDataRegion: .availableDataRegion)
    }

    init(apiClient: some APIClient, cache: some Cache, availableDataRegion: CoordinateRegionDataModel) {
        self.apiClient = apiClient
        self.cache = cache
        self.availableDataRegion = availableDataRegion
    }

    func neighbourhoods(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [NeighbourhoodReference] {
        Self.logger.trace("fetching Neighbourhoods in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)
        if let cachedNeighbourhoods = await cache.object(for: cacheKey, type: [NeighbourhoodReference].self) {
            return cachedNeighbourhoods
        }

        let dataModels: [NeighbourhoodReferenceDataModel]
        do {
            dataModels = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.list(policeForceID: policeForceID)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Neighbourhoods in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        let neighbourhoods = dataModels.map(NeighbourhoodReference.init)

        await cache.set(neighbourhoods, for: cacheKey)

        return neighbourhoods
    }

    func neighbourhood(withID id: String, inPoliceForce policeForceID: PoliceForce.ID) async throws -> Neighbourhood? {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Neighbourhood \(id, privacy: .public) in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodCachingKey(id: id, policeForceID: policeForceID)
        if let cachedNeighbourhood = await cache.object(for: cacheKey, type: Neighbourhood.self) {
            return cachedNeighbourhood
        }

        let dataModel: NeighbourhoodDataModel
        do {
            dataModel = try await apiClient.get(
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

        let neighbourhood = Neighbourhood(dataModel: dataModel)

        await cache.set(neighbourhood, for: cacheKey)

        return neighbourhood
    }

    func boundary(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                  inPoliceForce policeForceID: PoliceForce.ID) async throws -> [CLLocationCoordinate2D]? {
        // swiftlint:disable:next line_length
        Self.logger.trace("fetching Boundary for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        if let cachedBoundary = await cache.object(for: cacheKey, type: [CLLocationCoordinate2D].self) {
            return cachedBoundary
        }

        let dataModel: BoundaryDataModel
        do {
            dataModel = try await apiClient.get(
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

        let boundary = [CLLocationCoordinate2D](dataModel: dataModel)

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

        let dataModels: [PoliceOfficerDataModel]
        do {
            dataModels = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.policeOfficers(
                    neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
                )
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Police Officers for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        let policeOfficers = dataModels.map(PoliceOfficer.init)

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

        let dataModels: [NeighbourhoodPriorityDataModel]
        do {
            dataModels = try await apiClient.get(
                endpoint: NeighbourhoodsEndpoint.priorities(
                    neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
                )
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Priorities for Neighbourhood \(neighbourhoodID, privacy: .public) in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        let priorities = dataModels.map(NeighbourhoodPriority.init)

        await cache.set(priorities, for: cacheKey)

        return priorities
    }

    func neighbourhoodPolicingTeam(at coordinate: CLLocationCoordinate2D) async throws -> NeighbourhoodPolicingTeam? {
        Self.logger.trace("fetching Neighbourhood Policing Team at coordinate \(coordinate, privacy: .public)")

        let coordinate = CoordinateDataModel(coordinate: coordinate)

        guard availableDataRegion.contains(coordinate: coordinate) else {
            return nil
        }

        let dataModel: NeighbourhoodPolicingTeamDataModel
        do {
            dataModel = try await apiClient.get(
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

        let policingTeam = NeighbourhoodPolicingTeam(dataModel: dataModel)

        return policingTeam
    }

}
