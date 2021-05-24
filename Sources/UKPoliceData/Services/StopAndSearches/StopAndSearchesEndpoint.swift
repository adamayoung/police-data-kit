import Foundation

enum StopAndSearchesEndpoint {

    private static let basePath = URL(string: "/")!
    private static let stopsStreetBasePath = Self.basePath.appendingPathComponent("stops-street")
    private static let stopsAtLocationBasePath = Self.basePath.appendingPathComponent("stops-at-location")

    case stopAndSearchesByAreaAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case stopAndSearchesByAreaInArea(coordinates: [Coordinate], date: Date? = nil)
    case stopAndSearchesAtLocation(streetID: Int, date: Date? = nil)

}

extension StopAndSearchesEndpoint: Endpoint {

    var url: URL {
        switch self {
        case .stopAndSearchesByAreaAtSpecificPoint(let coordinate, let date):
            return Self.stopsStreetBasePath
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", date: date)

        case .stopAndSearchesByAreaInArea(let coordinates, let date):
            return Self.stopsStreetBasePath
                .appendingQueryItem(name: "poly", coordinates: coordinates)
                .appendingQueryItem(name: "date", date: date)

        case .stopAndSearchesAtLocation(let streetID, let date):
            return Self.stopsAtLocationBasePath
                .appendingQueryItem(name: "location_id", value: streetID)
                .appendingQueryItem(name: "date", date: date)
        }
    }

}
