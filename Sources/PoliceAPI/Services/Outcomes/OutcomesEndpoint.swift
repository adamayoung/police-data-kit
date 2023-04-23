import Foundation

enum OutcomesEndpoint {

    case streetLevelOutcomesForStreet(streetID: Int, date: Date)
    case streetLevelOutcomesAtSpecificPoint(coordinate: Coordinate, date: Date)
    case streetLevelOutcomesInArea(boundary: Boundary, date: Date)
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

        case .streetLevelOutcomesInArea(let boundary, let date):
            return Self.outcomesAtLocationBasePath
                .appendingQueryItem(name: "poly", boundary: boundary)
                .appendingQueryItem(name: "date", date: date)

        case .caseHistory(let crimeID):
            return Self.outcomesForCrimeBasePath
                .appendingPathComponent("\(crimeID)")
        }
    }

}
