import Foundation

enum PoliceForcesEndpoint {

    case list
    case details(id: String)
    case seniorOfficers(policeForceID: String)

}

extension PoliceForcesEndpoint: Endpoint {

    private static let basePath = URL(string: "/forces")!

    var path: URL {
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
