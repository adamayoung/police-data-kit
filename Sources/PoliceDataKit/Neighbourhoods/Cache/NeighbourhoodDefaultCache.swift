import CoreLocation
import Foundation

final class NeighbourhoodDefaultCache: NeighbourhoodCache {

    private let cacheStore: any Cache

    init(cacheStore: some Cache) {
        self.cacheStore = cacheStore
    }

    func neighbourhoods(inPoliceForce policeForceID: PoliceForce.ID) async -> [NeighbourhoodReference]? {
        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)
        let cachedNeighbourhoods = await cacheStore.object(for: cacheKey, type: [NeighbourhoodReference].self)

        return cachedNeighbourhoods
    }

    func setNeighbourhoods(_ neighbourhoods: [NeighbourhoodReference],
                           inPoliceForce policeForceID: PoliceForce.ID) async {
        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)

        await cacheStore.set(neighbourhoods, for: cacheKey)
    }

    func neighbourhood(withID id: String, inPoliceForce policeForceID: PoliceForce.ID) async -> Neighbourhood? {
        let cacheKey = NeighbourhoodCachingKey(id: id, policeForceID: policeForceID)
        let cachedNeighbourhood = await cacheStore.object(for: cacheKey, type: Neighbourhood.self)

        return cachedNeighbourhood
    }

    func setNeighbourhood(_ neighbourhood: Neighbourhood, withID id: String,
                          inPoliceForce policeForceID: PoliceForce.ID) async {
        let cacheKey = NeighbourhoodCachingKey(id: id, policeForceID: policeForceID)

        await cacheStore.set(neighbourhood, for: cacheKey)
    }

    func boundary(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                  inPoliceForce policeForceID: PoliceForce.ID) async -> [CLLocationCoordinate2D]? {
        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        let cachedBoundary = await cacheStore.object(for: cacheKey, type: [CLLocationCoordinate2D].self)

        return cachedBoundary
    }

    func setBoundary(_ coordinates: [CLLocationCoordinate2D], forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                     inPoliceForce policeForceID: PoliceForce.ID) async {
        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)

        await cacheStore.set(coordinates, for: cacheKey)
    }

    func policeOfficers(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                        inPoliceForce policeForceID: PoliceForce.ID) async -> [PoliceOfficer]? {
        let cacheKey = NeighbourhoodPoliceOfficersCachingKey(neighbourhoodID: neighbourhoodID,
                                                             policeForceID: policeForceID)
        let cachedPoliceOfficers = await cacheStore.object(for: cacheKey, type: [PoliceOfficer].self)

        return cachedPoliceOfficers
    }

    func setPoliceOfficers(_ policeOfficers: [PoliceOfficer], forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                           inPoliceForce policeForceID: PoliceForce.ID) async {
        let cacheKey = NeighbourhoodPoliceOfficersCachingKey(neighbourhoodID: neighbourhoodID,
                                                             policeForceID: policeForceID)

        await cacheStore.set(policeOfficers, for: cacheKey)
    }

    func priorities(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                    inPoliceForce policeForceID: PoliceForce.ID) async -> [NeighbourhoodPriority]? {
        let cacheKey = NeighbourhoodPrioritiesCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        let cachedPriorities = await cacheStore.object(for: cacheKey, type: [NeighbourhoodPriority].self)

        return cachedPriorities
    }

    func setPriorities(_ priorities: [NeighbourhoodPriority], forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                       inPoliceForce policeForceID: PoliceForce.ID) async {
        let cacheKey = NeighbourhoodPrioritiesCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)

        await cacheStore.set(priorities, for: cacheKey)
    }

}
