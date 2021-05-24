import Foundation

enum AvailabilityEndpoint {

    private static let dataSetsBasePath = URL(string: "/crimes-street-dates")!

    case dataSets

}

extension AvailabilityEndpoint: Endpoint {

    var url: URL {
        switch self {
        case .dataSets:
            return Self.dataSetsBasePath
        }
    }

}
