import Foundation

final class UKPoliceForceService: PoliceForceService {

    private let apiClient: any APIClient
    private let cache: any Cache

    init(apiClient: some APIClient, cache: some Cache) {
        self.apiClient = apiClient
        self.cache = cache
    }

    func policeForces() async throws -> [PoliceForceReference] {
        let cacheKey = PoliceForcesCachingKey()
        if let cachedPoliceForces = await cache.object(for: cacheKey, type: [PoliceForceReference].self) {
            return cachedPoliceForces
        }

        let policeForces: [PoliceForceReference] = try await apiClient.get(endpoint: PoliceForcesEndpoint.list)

        await cache.set(policeForces, for: cacheKey)

        return policeForces
    }

    func policeForce(withID id: PoliceForce.ID) async throws -> PoliceForce {
        let cacheKey = PoliceForceCachingKey(id: id)
        if let cachedPoliceForce = await cache.object(for: cacheKey, type: PoliceForce.self) {
            return cachedPoliceForce
        }

        let policeForce: PoliceForce = try await apiClient.get(endpoint: PoliceForcesEndpoint.details(id: id))

        await cache.set(policeForce, for: cacheKey)

        return policeForce
    }

    func seniorOfficers(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [PoliceOfficer] {
        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)
        if let cachedPeopleOfficers = await cache.object(for: cacheKey, type: [PoliceOfficer].self) {
            return cachedPeopleOfficers
        }

        let policeOfficers: [PoliceOfficer] = try await apiClient.get(
            endpoint: PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID)
        )

        await cache.set(policeOfficers, for: cacheKey)

        return policeOfficers
    }

}
