import Foundation

enum NeighbourhoodsEndpoint {

    static let basePath = URL(string: "/")!

    case list(policeForceID: String)
    case details(id: String, policeForceID: String)

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
        }
    }

}
