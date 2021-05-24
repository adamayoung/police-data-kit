import Foundation

enum CrimesEndpoint {

    private static let basePath = URL(string: "/")!
    private static let streetLevelCrimesAtLocationBasePath = basePath.appendingPathComponent("crimes-street")
    private static let crimesAtLocationBasePath = basePath.appendingPathComponent("crimes-at-location")
    private static let crimesWithNoLocationBasePath = basePath.appendingPathComponent("crimes-no-location")
    private static let crimeCategoriesBasePath = basePath.appendingPathComponent("crime-categories")

    case streetLevelCrimesAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case streetLevelCrimesInArea(coordinates: [Coordinate], date: Date? = nil)
    case crimesAtLocationForStreet(streetID: Int, date: Date? = nil)
    case crimesAtLocationAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case crimesWithNoLocation(categoryID: String, policeForceID: String, date: Date? = nil)
    case categories(date: Date)

}

extension CrimesEndpoint: Endpoint {

    var url: URL {
        switch self {
        case .streetLevelCrimesAtSpecificPoint(let coordinate, let date):
            return Self.streetLevelCrimesAtLocationBasePath
                .appendingPathComponent("all-crime")
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", date: date)

        case .streetLevelCrimesInArea(let coordinates, let date):
            return Self.streetLevelCrimesAtLocationBasePath
                .appendingPathComponent("all-crime")
                .appendingQueryItem(name: "poly", coordinates: coordinates)
                .appendingQueryItem(name: "date", date: date)

        case .crimesAtLocationForStreet(let streetID, let date):
            return Self.crimesAtLocationBasePath
                .appendingQueryItem(name: "location_id", value: streetID)
                .appendingQueryItem(name: "date", date: date)

        case .crimesAtLocationAtSpecificPoint(let coordinate, let date):
            return Self.crimesAtLocationBasePath
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", date: date)

        case .crimesWithNoLocation(let categoryID, let policeForceID, let date):
            return Self.crimesWithNoLocationBasePath
                .appendingQueryItem(name: "category", value: categoryID)
                .appendingQueryItem(name: "force", value: policeForceID)
                .appendingQueryItem(name: "date", date: date)

        case .categories(let date):
            return Self.crimeCategoriesBasePath
                .appendingQueryItem(name: "date", date: date)
        }
    }

}
