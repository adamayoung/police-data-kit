import Foundation

enum PoliceForcesEndpoint {

    case list
    case details(id: PoliceForce.ID)
    case seniorOfficers(policeForceID: PoliceForce.ID)

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

        case .seniorOfficers(let policeForceID):
            return Self.basePath
                .appendingPathComponent(policeForceID)
                .appendingPathComponent("people")
        }
    }

}
