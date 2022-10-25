import Foundation

enum OutcomesEndpoint {

    case streetLevelOutcomesForStreet(streetID: Int, date: Date? = nil)
    case streetLevelOutcomesAtSpecificPoint(coordinate: Coordinate, date: Date? = nil)
    case streetLevelOutcomesInArea(coordinates: [Coordinate], date: Date? = nil)
    case caseHistory(crimeID: String)

}

extension OutcomesEndpoint: Endpoint {

    private static let outcomesAtLocationBasePath = URL(string: "/outcomes-at-location")!
    private static let outcomesForCrimeBasePath = URL(string: "/outcomes-for-crime")!

    var path: URL {
        switch self {
        case .streetLevelOutcomesForStreet(let streetID, let date):
            return Self.outcomesAtLocationBasePath
                .appendingQueryItem(name: "location_id", value: streetID)
                .appendingQueryItem(name: "date", date: date)

        case .streetLevelOutcomesAtSpecificPoint(let coordinate, let date):
            return Self.outcomesAtLocationBasePath
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", date: date)

        case .streetLevelOutcomesInArea(let coordinates, let date):
            return Self.outcomesAtLocationBasePath
                .appendingQueryItem(name: "poly", coordinates: coordinates)
                .appendingQueryItem(name: "date", date: date)

        case .caseHistory(let crimeID):
            return Self.outcomesForCrimeBasePath
                .appendingPathComponent(crimeID)
        }
    }

}
