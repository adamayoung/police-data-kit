import Foundation

final class UKNeighbourhoodService: NeighbourhoodService {

    private let apiClient: any APIClient
    private let cache: any Cache

    init(apiClient: some APIClient, cache: some Cache) {
        self.apiClient = apiClient
        self.cache = cache
    }

    func neighbourhoods(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [NeighbourhoodReference] {
        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)
        if let cachedNeighbourhoods = await cache.object(for: cacheKey, type: [NeighbourhoodReference].self) {
            return cachedNeighbourhoods
        }

        let neighbourhoods: [NeighbourhoodReference] = try await apiClient.get(
            endpoint: NeighbourhoodsEndpoint.list(policeForceID: policeForceID)
        )

        await cache.set(neighbourhoods, for: cacheKey)

        return neighbourhoods
    }

    func neighbourhood(withID id: String, inPoliceForce policeForceID: String) async throws -> Neighbourhood {
        let cacheKey = NeighbourhoodCachingKey(id: id, policeForceID: policeForceID)
        if let cachedNeighbourhood = await cache.object(for: cacheKey, type: Neighbourhood.self) {
            return cachedNeighbourhood
        }

        let neighbourhood: Neighbourhood = try await apiClient.get(
            endpoint: NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID)
        )

        await cache.set(neighbourhood, for: cacheKey)

        return neighbourhood
    }

    func boundary(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                  inPoliceForce policeForceID: PoliceForce.ID) async throws -> Boundary {
        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        if let cachedBoundary = await cache.object(for: cacheKey, type: Boundary.self) {
            return cachedBoundary
        }

        let boundary: Boundary = try await apiClient.get(
            endpoint: NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        )

        await cache.set(boundary, for: cacheKey)

        return boundary
    }

    func policeOfficers(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                        inPoliceForce policeForceID: PoliceForce.ID) async throws -> [PoliceOfficer] {
        let cacheKey = NeighbourhoodPoliceOfficersCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )
        if let cachedPoliceOfficers = await cache.object(for: cacheKey, type: [PoliceOfficer].self) {
            return cachedPoliceOfficers
        }

        let policeOfficers: [PoliceOfficer] = try await apiClient.get(
            endpoint: NeighbourhoodsEndpoint.policeOfficers(
                neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
            )
        )

        await cache.set(policeOfficers, for: cacheKey)

        return policeOfficers
    }

    func priorities(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                    inPoliceForce policeForceID: PoliceForce.ID) async throws -> [NeighbourhoodPriority] {
        let cacheKey = NeighbourhoodPrioritiesCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )
        if let cachedPriorities = await cache.object(for: cacheKey, type: [NeighbourhoodPriority].self) {
            return cachedPriorities
        }

        let priorities: [NeighbourhoodPriority] = try await apiClient.get(
            endpoint: NeighbourhoodsEndpoint.priorities(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        )

        await cache.set(priorities, for: cacheKey)

        return priorities
    }

    func neighbourhoodPolicingTeam(atCoordinate coordinate: Coordinate) async throws -> NeighbourhoodPolicingTeam {
        try await apiClient.get(endpoint: NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate))
    }

}
