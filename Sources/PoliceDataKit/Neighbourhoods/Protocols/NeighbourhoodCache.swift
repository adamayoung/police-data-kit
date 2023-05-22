import CoreLocation
import Foundation

protocol NeighbourhoodCache {

    func neighbourhoods(inPoliceForce policeForceID: PoliceForce.ID) async -> [NeighbourhoodReference]?

    func setNeighbourhoods(_ neighbourhoods: [NeighbourhoodReference],
                           inPoliceForce policeForceID: PoliceForce.ID) async

    func neighbourhood(withID id: String, inPoliceForce policeForceID: PoliceForce.ID) async -> Neighbourhood?

    func setNeighbourhood(_ neighbourhood: Neighbourhood, withID id: String,
                          inPoliceForce policeForceID: PoliceForce.ID) async

    func boundary(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                  inPoliceForce policeForceID: PoliceForce.ID) async -> [CLLocationCoordinate2D]?

    func setBoundary(_ coordinates: [CLLocationCoordinate2D], forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                     inPoliceForce policeForceID: PoliceForce.ID) async

    func policeOfficers(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                        inPoliceForce policeForceID: PoliceForce.ID) async -> [PoliceOfficer]?

    func setPoliceOfficers(_ policeOfficers: [PoliceOfficer], forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                           inPoliceForce policeForceID: PoliceForce.ID) async

    func priorities(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                    inPoliceForce policeForceID: PoliceForce.ID) async -> [NeighbourhoodPriority]?

    func setPriorities(_ priorities: [NeighbourhoodPriority], forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                       inPoliceForce policeForceID: PoliceForce.ID) async

}
