import Foundation

enum CrimesEndpoint {

    static let basePath = URL(string: "/")!

    case streetLevelAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case streetLevelInCustomArea(coordinates: [Coordinate], date: Date? = nil)
    case categories(date: Date)

}

extension CrimesEndpoint: Endpoint {

    var url: URL {
        switch self {
        case .streetLevelAtSpecificPoint(let coordinate, let date):
            return Self.basePath
                .appendingPathComponent("crimes-at-location")
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", value: date)

        case .streetLevelInCustomArea(let coordinates, let date):
            return Self.basePath
                .appendingPathComponent("crimes-at-location")
                .appendingQueryItem(name: "poly", value: coordinates)
                .appendingQueryItem(name: "date", value: date)

        case .categories(let date):
            return Self.basePath
                .appendingPathComponent("crime-categories")
                .appendingQueryItem(name: "date", value: date, formatter: .yearMonth)
        }
    }

}
