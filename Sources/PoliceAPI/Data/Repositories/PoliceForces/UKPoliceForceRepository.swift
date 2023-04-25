import Foundation
import os

final class UKPoliceForceRepository: PoliceForceRepository {

    private static let logger = Logger(subsystem: Logger.dataSubsystem, category: "PoliceForceService")

    private let apiClient: any APIClient
    private let cache: any Cache

    init(apiClient: some APIClient, cache: some Cache) {
        self.apiClient = apiClient
        self.cache = cache
    }

    func policeForces() async throws -> [PoliceForceReferenceDataModel] {
        Self.logger.trace("fetching Police Forces")

        let cacheKey = PoliceForcesCachingKey()
        if let cachedPoliceForces = await cache.object(for: cacheKey, type: [PoliceForceReferenceDataModel].self) {
            return cachedPoliceForces
        }

        let policeForces: [PoliceForceReferenceDataModel]
        do {
            policeForces = try await apiClient.get(endpoint: PoliceForcesEndpoint.list)
        } catch let error {
            Self.logger.error("failed fetching Police Forces: \(error.localizedDescription, privacy: .public)")
            throw error
        }

        await cache.set(policeForces, for: cacheKey)

        return policeForces
    }

    func policeForce(withID id: PoliceForceDataModel.ID) async throws -> PoliceForceDataModel? {
        Self.logger.trace("fetching Police Force \(id, privacy: .public)")

        let cacheKey = PoliceForceCachingKey(id: id)
        if let cachedPoliceForce = await cache.object(for: cacheKey, type: PoliceForceDataModel.self) {
            return cachedPoliceForce
        }

        let policeForce: PoliceForceDataModel
        do {
            policeForce = try await apiClient.get(endpoint: PoliceForcesEndpoint.details(id: id))
        } catch let error {
            switch error as? PoliceDataError {
            case .notFound:
                return nil
            default:
                break
            }

            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Police Force \(id, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        await cache.set(policeForce, for: cacheKey)

        return policeForce
    }

    func seniorOfficers(inPoliceForce policeForceID: PoliceForceDataModel.ID) async throws -> [PoliceOfficerDataModel]? {
        Self.logger.trace("fetching Senior Officers in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)
        if let cachedPeopleOfficers = await cache.object(for: cacheKey, type: [PoliceOfficerDataModel].self) {
            return cachedPeopleOfficers
        }

        let policeOfficers: [PoliceOfficerDataModel]
        do {
            policeOfficers = try await apiClient.get(
                endpoint: PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID)
            )
        } catch let error {
            switch error as? PoliceDataError {
            case .notFound:
                return nil
            default:
                break
            }

            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Senior Officers in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        await cache.set(policeOfficers, for: cacheKey)

        return policeOfficers
    }

}
