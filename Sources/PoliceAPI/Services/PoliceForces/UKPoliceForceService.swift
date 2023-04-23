import Foundation
import os

final class UKPoliceForceService: PoliceForceService {

    private static let logger = Logger(subsystem: Logger.subsystem, category: "PoliceForceService")

    private let apiClient: any APIClient
    private let cache: any Cache

    init(apiClient: some APIClient, cache: some Cache) {
        self.apiClient = apiClient
        self.cache = cache
    }

    func policeForces() async throws -> [PoliceForceReference] {
        Self.logger.trace("fetching Police Forces")

        let cacheKey = PoliceForcesCachingKey()
        if let cachedPoliceForces = await cache.object(for: cacheKey, type: [PoliceForceReference].self) {
            return cachedPoliceForces
        }

        let policeForces: [PoliceForceReference]
        do {
            policeForces = try await apiClient.get(endpoint: PoliceForcesEndpoint.list)
        } catch let error {
            Self.logger.error("failed fetching Police Forces: \(error.localizedDescription, privacy: .public)")
            throw error
        }

        await cache.set(policeForces, for: cacheKey)

        return policeForces
    }

    func policeForce(withID id: PoliceForce.ID) async throws -> PoliceForce {
        Self.logger.trace("fetching Police Force \(id, privacy: .public)")

        let cacheKey = PoliceForceCachingKey(id: id)
        if let cachedPoliceForce = await cache.object(for: cacheKey, type: PoliceForce.self) {
            return cachedPoliceForce
        }

        let policeForce: PoliceForce
        do {
            policeForce = try await apiClient.get(endpoint: PoliceForcesEndpoint.details(id: id))
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Police Force \(id, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        await cache.set(policeForce, for: cacheKey)

        return policeForce
    }

    func seniorOfficers(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [PoliceOfficer] {
        Self.logger.trace("fetching Senior Officers in Police Force \(policeForceID, privacy: .public)")

        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)
        if let cachedPeopleOfficers = await cache.object(for: cacheKey, type: [PoliceOfficer].self) {
            return cachedPeopleOfficers
        }

        let policeOfficers: [PoliceOfficer]

        do {
            policeOfficers = try await apiClient.get(
                endpoint: PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID)
            )
        } catch let error {
            // swiftlint:disable:next line_length
            Self.logger.error("failed fetching Senior Officers in Police Force \(policeForceID, privacy: .public): \(error.localizedDescription, privacy: .public)")
            throw error
        }

        await cache.set(policeOfficers, for: cacheKey)

        return policeOfficers
    }

}
