import Foundation

enum StopAndSearchesEndpoint {

    case stopAndSearchesByAreaAtSpecificPoint(coordinate: CoordinateDataModel, date: Date)
    case stopAndSearchesByAreaInArea(boundary: BoundaryDataModel, date: Date)
    case stopAndSearchesAtLocation(streetID: Int, date: Date)
    case stopAndSearchesWithNoLocation(policeForceID: PoliceForceDataModel.ID, date: Date)
    case stopAndSearchesByPoliceForce(policeForceID: PoliceForceDataModel.ID, date: Date)

}

extension StopAndSearchesEndpoint: Endpoint {

    private static let basePath = URL(string: "/")!
    private static let stopsStreetBasePath = URL(string: "/stops-street")!
    private static let stopsAtLocationBasePath = URL(string: "/stops-at-location")!
    private static let stopsNoLocationBasePath = URL(string: "/stops-no-location")!
    private static let stopsForceBasePath = URL(string: "/stops-force")!

    var path: URL {
        switch self {
        case .stopAndSearchesByAreaAtSpecificPoint(let coordinate, let date):
            return Self.stopsStreetBasePath
                .appendingQueryItem(name: "lat", value: coordinate.latitude)
                .appendingQueryItem(name: "lng", value: coordinate.longitude)
                .appendingQueryItem(name: "date", date: date)

        case .stopAndSearchesByAreaInArea(let boundary, let date):
            return Self.stopsStreetBasePath
                .appendingQueryItem(name: "poly", boundary: boundary)
                .appendingQueryItem(name: "date", date: date)

        case .stopAndSearchesAtLocation(let streetID, let date):
            return Self.stopsAtLocationBasePath
                .appendingQueryItem(name: "location_id", value: streetID)
                .appendingQueryItem(name: "date", date: date)

        case .stopAndSearchesWithNoLocation(let policeForceID, let date):
            return Self.stopsNoLocationBasePath
                .appendingQueryItem(name: "force", value: policeForceID)
                .appendingQueryItem(name: "date", date: date)

        case .stopAndSearchesByPoliceForce(let policeForceID, let date):
            return Self.stopsForceBasePath
                .appendingQueryItem(name: "force", value: policeForceID)
                .appendingQueryItem(name: "date", date: date)
        }
    }

}
