import CoreLocation
import Foundation

enum NeighbourhoodsEndpoint {

    case list(policeForceID: PoliceForce.ID)
    case details(id: Neighbourhood.ID, policeForceID: PoliceForce.ID)
    case boundary(neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID)
    case policeOfficers(neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID)
    case priorities(neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID)
    case locateNeighbourhood(coordinate: CLLocationCoordinate2D)

}

extension NeighbourhoodsEndpoint: Endpoint {

    private static let basePath = URL(string: "/")!

    var path: URL {
        switch self {
        case .list(let policeForceID):
            return Self.basePath
                .appendingPathComponent(policeForceID)
                .appendingPathComponent("neighbourhoods")

        case .details(let id, let policeForceID):
            return Self.basePath
                .appendingPathComponent(policeForceID)
                .appendingPathComponent(id)

        case .boundary(let neighbourhoodID, let policeForceID):
            return Self.basePath
                .appendingPathComponent(policeForceID)
                .appendingPathComponent(neighbourhoodID)
                .appendingPathComponent("boundary")

        case .policeOfficers(let neighbourhoodID, let policeForceID):
            return Self.basePath
                .appendingPathComponent(policeForceID)
                .appendingPathComponent(neighbourhoodID)
                .appendingPathComponent("people")

        case .priorities(let neighbourhoodID, let policeForceID):
            return Self.basePath
                .appendingPathComponent(policeForceID)
                .appendingPathComponent(neighbourhoodID)
                .appendingPathComponent("priorities")

        case .locateNeighbourhood(let coordinate):
            return Self.basePath
                .appendingPathComponent("locate-neighbourhood")
                .appendingQueryItem(name: "q", coordinate: coordinate)
        }
    }

}
