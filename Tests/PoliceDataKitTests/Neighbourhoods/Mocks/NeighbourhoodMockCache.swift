import CoreLocation
import Foundation
@testable import PoliceDataKit

final class NeighbourhoodMockCache: NeighbourhoodCache {

    private var cacheStore: [String: Any] = [:]

    private enum CacheKey {

        static func neighbourhoods(policeForceID: PoliceForce.ID) -> String {
            "neighbourhoods-police-force-\(policeForceID)"
        }

        static func neighbourhood(id: String, policeForceID: PoliceForce.ID) -> String {
            "neighbourhood-\(id)"
        }

        static func boundary(neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID) -> String {
            "boundary-neighbourhood-\(neighbourhoodID)-police-force-\(policeForceID)"
        }

        static func policeOfficers(neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID) -> String {
            "police-officers-neighbourhood-\(neighbourhoodID)-police-force-\(policeForceID)"
        }

        static func priorities(neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID) -> String {
            "priorities-neighbourhood-\(neighbourhoodID)-police-force-\(policeForceID)"
        }

    }

    func neighbourhoods(inPoliceForce policeForceID: PoliceForce.ID) async -> [NeighbourhoodReference]? {
        cacheStore[CacheKey.neighbourhoods(policeForceID: policeForceID)] as? [NeighbourhoodReference]
    }

    func setNeighbourhoods(_ neighbourhoods: [NeighbourhoodReference],
                           inPoliceForce policeForceID: PoliceForce.ID) async {
        cacheStore[CacheKey.neighbourhoods(policeForceID: policeForceID)] = neighbourhoods
    }

    func neighbourhood(withID id: String, inPoliceForce policeForceID: PoliceForce.ID) async -> Neighbourhood? {
        cacheStore[CacheKey.neighbourhood(id: id, policeForceID: policeForceID)] as? Neighbourhood
    }

    func setNeighbourhood(_ neighbourhood: Neighbourhood, withID id: String,
                          inPoliceForce policeForceID: PoliceForce.ID) async {
        cacheStore[CacheKey.neighbourhood(id: id, policeForceID: policeForceID)] = neighbourhood
    }

    func boundary(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                  inPoliceForce policeForceID: PoliceForce.ID) async -> [CLLocationCoordinate2D]? {
        let key = CacheKey.boundary(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        return cacheStore[key] as? [CLLocationCoordinate2D]
    }

    func setBoundary(_ coordinates: [CLLocationCoordinate2D], forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                     inPoliceForce policeForceID: PoliceForce.ID) async {
        let key = CacheKey.boundary(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        cacheStore[key] = coordinates
    }

    func policeOfficers(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                        inPoliceForce policeForceID: PoliceForce.ID) async -> [PoliceOfficer]? {
        let key = CacheKey.policeOfficers(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        return cacheStore[key] as? [PoliceOfficer]
    }

    func setPoliceOfficers(_ policeOfficers: [PoliceOfficer], forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                           inPoliceForce policeForceID: PoliceForce.ID) async {
        let key = CacheKey.policeOfficers(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        cacheStore[key] = policeOfficers
    }

    func priorities(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                    inPoliceForce policeForceID: PoliceForce.ID) async -> [NeighbourhoodPriority]? {
        let key = CacheKey.priorities(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        return cacheStore[key] as? [NeighbourhoodPriority]
    }

    func setPriorities(_ priorities: [NeighbourhoodPriority], forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                       inPoliceForce policeForceID: PoliceForce.ID) async {
        let key = CacheKey.priorities(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        cacheStore[key] = priorities
    }

}
