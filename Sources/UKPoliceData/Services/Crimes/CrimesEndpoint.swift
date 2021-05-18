import Foundation

enum CrimesEndpoint {

    static let basePath = URL(string: "/")!

    case streetLevelCrimesAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case streetLevelCrimesInCustomArea(coordinates: [Coordinate], date: Date? = nil)
    case streetLevelOutcomesForStreet(streetID: Int, date: Date? = nil)
    case streetLevelOutcomesAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case categories(date: Date)

}

extension CrimesEndpoint: Endpoint {

    var url: URL {
        switch self {
        case .streetLevelCrimesAtSpecificPoint(let coordinate, let date):
            return Self.basePath
                .appendingPathComponent("crimes-at-location")
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", value: date)

        case .streetLevelCrimesInCustomArea(let coordinates, let date):
            return Self.basePath
                .appendingPathComponent("crimes-at-location")
                .appendingQueryItem(name: "poly", value: coordinates)
                .appendingQueryItem(name: "date", value: date)

        case .streetLevelOutcomesForStreet(let streetID, let date):
            return Self.basePath
                .appendingPathComponent("outcomes-at-location")
                .appendingQueryItem(name: "location_id", value: streetID)
                .appendingQueryItem(name: "date", value: date)

        case .streetLevelOutcomesAtSpecificPoint(let coordinate, let date):
            return Self.basePath
                .appendingPathComponent("outcomes-at-location")
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", value: date)

        case .categories(let date):
            return Self.basePath
                .appendingPathComponent("crime-categories")
                .appendingQueryItem(name: "date", value: date, formatter: .yearMonth)
        }
    }

}
