import Foundation

enum NeighbourhoodsEndpoint {

    case list(policeForceID: PoliceForceDataModel.ID)
    case details(id: NeighbourhoodDataModel.ID, policeForceID: PoliceForceDataModel.ID)
    case boundary(neighbourhoodID: NeighbourhoodDataModel.ID, policeForceID: PoliceForceDataModel.ID)
    case policeOfficers(neighbourhoodID: NeighbourhoodDataModel.ID, policeForceID: PoliceForceDataModel.ID)
    case priorities(neighbourhoodID: NeighbourhoodDataModel.ID, policeForceID: PoliceForceDataModel.ID)
    case locateNeighbourhood(coordinate: CoordinateDataModel)

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
