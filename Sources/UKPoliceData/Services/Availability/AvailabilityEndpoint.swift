import Foundation

enum AvailabilityEndpoint {

    case dataSets

}

extension AvailabilityEndpoint: Endpoint {

    private static let dataSetsBasePath = URL(string: "/crimes-street-dates")!

    var path: URL {
        switch self {
        case .dataSets:
            return Self.dataSetsBasePath
        }
    }

}
