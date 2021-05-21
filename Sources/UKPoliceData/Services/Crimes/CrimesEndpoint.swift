import Foundation

enum CrimesEndpoint {

    private static let basePath = URL(string: "/")!
    private static let streetLevelCrimesAtLocationBasePath = basePath.appendingPathComponent("crimes-street")
    private static let outcomesAtLocationBasePath = basePath.appendingPathComponent("outcomes-at-location")
    private static let crimesAtLocationBasePath = basePath.appendingPathComponent("crimes-at-location")
    private static let crimeCategoriesBasePath = basePath.appendingPathComponent("crime-categories")
    private static let crimesWithNoLocationBasePath = basePath.appendingPathComponent("crimes-no-location")
    private static let outcomesForCrimeBasePath = basePath.appendingPathComponent("outcomes-for-crime")

    case streetLevelCrimesAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case streetLevelCrimesInArea(coordinates: [Coordinate], date: Date? = nil)
    case streetLevelOutcomesForStreet(streetID: Int, date: Date? = nil)
    case streetLevelOutcomesAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case streetLevelOutcomesInArea(coordinates: [Coordinate], date: Date? = nil)
    case crimesAtLocationForStreet(streetID: Int, date: Date? = nil)
    case crimesAtLocationAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case crimesWithNoLocation(categoryID: String, policeForceID: String, date: Date? = nil)
    case caseHistory(crimeID: String)
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
                .appendingQueryItem(name: "date", value: date)

        case .streetLevelCrimesInArea(let coordinates, let date):
            return Self.streetLevelCrimesAtLocationBasePath
                .appendingPathComponent("all-crime")
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

        case .crimesAtLocationForStreet(let streetID, let date):
            return Self.crimesAtLocationBasePath
                .appendingQueryItem(name: "location_id", value: streetID)
                .appendingQueryItem(name: "date", value: date)

        case .crimesAtLocationAtSpecificPoint(let coordinate, let date):
            return Self.crimesAtLocationBasePath
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", value: date)

        case .crimesWithNoLocation(let categoryID, let policeForceID, let date):
            return Self.crimesWithNoLocationBasePath
                .appendingQueryItem(name: "category", value: categoryID)
                .appendingQueryItem(name: "force", value: policeForceID)
                .appendingQueryItem(name: "date", value: date)

        case .caseHistory(let crimeID):
            return Self.outcomesForCrimeBasePath
                .appendingPathComponent(crimeID)

        case .categories(let date):
            return Self.crimeCategoriesBasePath
                .appendingQueryItem(name: "date", value: date, formatter: .yearMonth)
        }
    }

}
