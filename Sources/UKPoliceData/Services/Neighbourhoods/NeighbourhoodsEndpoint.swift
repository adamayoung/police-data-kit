import Foundation

enum NeighbourhoodsEndpoint {

    static let basePath = URL(string: "/")!

    case list(policeForceID: String)
    case details(id: String, policeForceID: String)
    case boundary(neighbourhoodID: String, policeForceID: String)
    case policeOfficers(neighbourhoodID: String, policeForceID: String)
    case priorities(neighbourhoodID: String, policeForceID: String)
    case locateNeighbourhood(latitude: Double, longitude: Double)

}

extension NeighbourhoodsEndpoint: Endpoint {

    var url: URL {
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

        case .locateNeighbourhood(let latitude, let longitude):
            return Self.basePath
                .appendingPathComponent("locate-neighbourhood")
                .appendingQueryItem(name: "q", value: "\(latitude),\(longitude)")
        }
    }

}
