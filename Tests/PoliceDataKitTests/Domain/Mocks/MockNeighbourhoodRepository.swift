import CoreLocation
import Foundation
@testable import PoliceDataKit

final class MockNeighbourhoodRepository: NeighbourhoodRepository {

    var neighbourhoodsResult: Result<[NeighbourhoodReference], Error> = .failure(NeighbourhoodError.unknown)
    var lastNeighbourhoodsParameter: PoliceForce.ID?

    var neighbourhoodResult: Result<Neighbourhood, Error> = .failure(NeighbourhoodError.unknown)
    var lastNeighbourhoodParameters: (id: Neighbourhood.ID, policeForceID: PoliceForce.ID)?

    var boundaryResult: Result<[CLLocationCoordinate2D], Error> = .failure(NeighbourhoodError.unknown)
    var lastBoundaryParameters: (neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID)?

    var policeOfficersResult: Result<[PoliceOfficer], Error> = .failure(NeighbourhoodError.unknown)
    var lastPoliceOfficersParameters: (neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID)?

    var prioritiesResult: Result<[NeighbourhoodPriority], Error> = .failure(NeighbourhoodError.unknown)
    var lastPrioritiesParameters: (neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID)?

    var neighbourhoodPolicingTeamResult: Result<NeighbourhoodPolicingTeam, Error> = .failure(NeighbourhoodError.unknown)
    var lastNeighbourhoodPolicingTeamParameter: CLLocationCoordinate2D?

    init() { }

    func neighbourhoods(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [NeighbourhoodReference] {
        lastNeighbourhoodsParameter = policeForceID

        return try neighbourhoodsResult.get()
    }

    func neighbourhood(withID id: Neighbourhood.ID,
                       inPoliceForce policeForceID: PoliceForce.ID) async throws -> Neighbourhood {
        lastNeighbourhoodParameters = (id: id, policeForceID: policeForceID)

        return try neighbourhoodResult.get()
    }

    func boundary(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                  inPoliceForce policeForceID: PoliceForce.ID) async throws -> [CLLocationCoordinate2D] {
        lastBoundaryParameters = (neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)

        return try boundaryResult.get()
    }

    func policeOfficers(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                        inPoliceForce policeForceID: PoliceForce.ID) async throws -> [PoliceOfficer] {
        lastPoliceOfficersParameters = (neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)

        return try policeOfficersResult.get()
    }

    func priorities(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                    inPoliceForce policeForceID: PoliceForce.ID) async throws -> [NeighbourhoodPriority] {
        lastPoliceOfficersParameters = (neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)

        return try prioritiesResult.get()
    }

    func neighbourhoodPolicingTeam(at coordinate: CLLocationCoordinate2D) async throws -> NeighbourhoodPolicingTeam {
        lastNeighbourhoodPolicingTeamParameter = coordinate

        return try neighbourhoodPolicingTeamResult.get()
    }

}
