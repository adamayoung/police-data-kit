import Foundation

enum CrimesEndpoint {

    static let basePath = URL(string: "/")!
    static let crimesAtLocationBasePath = basePath.appendingPathComponent("crimes-at-location")
    static let outcomesAtLocationBasePath = basePath.appendingPathComponent("outcomes-at-location")
    static let crimeCategoriesBasePath = basePath.appendingPathComponent("crime-categories")

    case streetLevelCrimesAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case streetLevelCrimesInArea(coordinates: [Coordinate], date: Date? = nil)
    case streetLevelOutcomesForStreet(streetID: Int, date: Date? = nil)
    case streetLevelOutcomesAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case streetLevelOutcomesInArea(coordinates: [Coordinate], date: Date? = nil)
    case categories(date: Date)

}

extension CrimesEndpoint: Endpoint {

    var url: URL {
        switch self {
        case .streetLevelCrimesAtSpecificPoint(let coordinate, let date):
            return Self.crimesAtLocationBasePath
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", value: date)

        case .streetLevelCrimesInArea(let coordinates, let date):
            return Self.crimesAtLocationBasePath
                .appendingQueryItem(name: "poly", value: coordinates)
                .appendingQueryItem(name: "date", value: date)

        case .streetLevelOutcomesForStreet(let streetID, let date):
            return Self.outcomesAtLocationBasePath
                .appendingQueryItem(name: "location_id", value: streetID)
                .appendingQueryItem(name: "date", value: date)

        case .streetLevelOutcomesAtSpecificPoint(let coordinate, let date):
            return Self.outcomesAtLocationBasePath
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", value: date)

        case .streetLevelOutcomesInArea(let coordinates, let date):
            return Self.outcomesAtLocationBasePath
                .appendingQueryItem(name: "poly", value: coordinates)
                .appendingQueryItem(name: "date", value: date)

        case .categories(let date):
            return Self.crimeCategoriesBasePath
                .appendingQueryItem(name: "date", value: date, formatter: .yearMonth)
        }
    }

}
