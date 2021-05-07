import Foundation

enum PoliceForcesEndpoint {

    static let basePath = URL(string: "/forces")!

    case list
    case details(id: String)
    case seniorOfficers(policeForceID: String)

}

extension PoliceForcesEndpoint: Endpoint {

    var url: URL {
        switch self {
        case .list:
            return Self.basePath

        case .details(let id):
            return Self.basePath
                .appendingPathComponent(id)

        case .seniorOfficers(let policeForceId):
            return Self.basePath
                .appendingPathComponent(policeForceId)
                .appendingPathComponent("people")
        }
    }

}
