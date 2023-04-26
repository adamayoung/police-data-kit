import CoreLocation
import Foundation

protocol NeighbourhoodRepository {

    func neighbourhoods(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [NeighbourhoodReference]

    func neighbourhood(withID id: Neighbourhood.ID,
                       inPoliceForce policeForceID: PoliceForce.ID) async throws -> Neighbourhood?

    func boundary(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                  inPoliceForce policeForceID: PoliceForce.ID) async throws -> [CLLocationCoordinate2D]?

    func policeOfficers(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                        inPoliceForce policeForceID: PoliceForce.ID) async throws -> [PoliceOfficer]

    func priorities(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                    inPoliceForce policeForceID: PoliceForce.ID) async throws -> [NeighbourhoodPriority]

    func neighbourhoodPolicingTeam(at coordinate: CLLocationCoordinate2D) async throws -> NeighbourhoodPolicingTeam?

}
