import Foundation

enum CrimesEndpoint {

    case streetLevelCrimesAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case streetLevelCrimesInArea(boundary: Boundary, date: Date? = nil)
    case crimesAtLocationForStreet(streetID: Int, date: Date? = nil)
    case crimesAtLocationAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case crimesWithNoLocation(categoryID: CrimeCategory.ID, policeForceID: PoliceForce.ID, date: Date? = nil)
    case categories(date: Date)

}

extension CrimesEndpoint: Endpoint {

    private static let streetLevelCrimesAtLocationBasePath = URL(string: "/crimes-street")!
    private static let crimesAtLocationBasePath = URL(string: "/crimes-at-location")!
    private static let crimesWithNoLocationBasePath = URL(string: "/crimes-no-location")!
    private static let crimeCategoriesBasePath = URL(string: "/crime-categories")!

    var path: URL {
        switch self {
        case .streetLevelCrimesAtSpecificPoint(let coordinate, let date):
            return Self.streetLevelCrimesAtLocationBasePath
                .appendingPathComponent("all-crime")
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", date: date)

        case .streetLevelCrimesInArea(let boundary, let date):
            return Self.streetLevelCrimesAtLocationBasePath
                .appendingPathComponent("all-crime")
                .appendingQueryItem(name: "poly", boundary: boundary)
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
