import Foundation

enum StopAndSearchesEndpoint {

    private static let basePath = URL(string: "/")!
    private static let stopsStreetBasePath = Self.basePath.appendingPathComponent("stops-street")

    case stopAndSearchesByAreaAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)

}

extension StopAndSearchesEndpoint: Endpoint {

    var url: URL {
        switch self {
        case .stopAndSearchesByAreaAtSpecificPoint(let coordinate, let date):
            return Self.stopsStreetBasePath
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", value: date)
        }
    }

}
