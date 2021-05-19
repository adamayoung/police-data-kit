import Foundation

#if canImport(Combine)
import Combine
#endif

final class UKCrimeService: CrimeService {

    private let apiClient: APIClient

    init(apiClient: APIClient = PoliceDataAPIClient.shared) {
        self.apiClient = apiClient
    }

    func fetchStreetLevelCrimes(atCoordinate coordinate: Coordinate, date: Date?,
                                completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date),
                      completion: completion)
    }

    func fetchStreetLevelCrimes(inArea coordinates: [Coordinate], date: Date?,
                                completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: CrimesEndpoint.streetLevelCrimesInArea(coordinates: coordinates, date: date),
                      completion: completion)
    }

    func fetchStreetLevelOutcomes(forStreet streetID: Int, date: Date?,
                                  completion: @escaping (_ result: Result<[Outcome], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: CrimesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date),
                      completion: completion)
    }

    func fetchStreetLevelOutcomes(atCoordinate coordinate: Coordinate, date: Date?,
                                  completion: @escaping (_ result: Result<[Outcome], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: CrimesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date),
                      completion: completion)
    }

    func fetchStreetLevelOutcomes(inArea coordinates: [Coordinate], date: Date?,
                                  completion: @escaping (_ result: Result<[Outcome], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: CrimesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date),
                      completion: completion)
    }

    func fetchCrimesAtLocation(forStreet streetID: Int, date: Date?,
                               completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date),
                      completion: completion)
    }

    func fetchCrimesAtLocation(atCoordinate coordinate: Coordinate, date: Date?,
                               completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date),
                      completion: completion)
    }

    func fetchCategories(date: Date,
                         completion: @escaping (_ result: Result<[CrimeCategory], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: CrimesEndpoint.categories(date: date), completion: completion)
    }

}

#if canImport(Combine)
extension UKCrimeService {

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelCrimesPublisher(atCoordinate coordinate: Coordinate,
                                    date: Date?) -> AnyPublisher<[Crime], PoliceDataError> {
        apiClient.get(endpoint: CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date))
    }
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelCrimesPublisher(inArea coordinates: [Coordinate],
                                    date: Date?) -> AnyPublisher<[Crime], PoliceDataError> {
        apiClient.get(endpoint: CrimesEndpoint.streetLevelCrimesInArea(coordinates: coordinates, date: date))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelOutcomesPublisher(forStreet streetID: Int,
                                      date: Date?) -> AnyPublisher<[Outcome], PoliceDataError> {
        apiClient.get(endpoint: CrimesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelOutcomesPublisher(atCoordinate coordinate: Coordinate,
                                      date: Date?) -> AnyPublisher<[Outcome], PoliceDataError> {
        apiClient.get(endpoint: CrimesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelOutcomesPublisher(inArea coordinates: [Coordinate],
                                      date: Date?) -> AnyPublisher<[Outcome], PoliceDataError> {
        apiClient.get(endpoint: CrimesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimesAtLocationPublisher(forStreet streetID: Int, date: Date?) -> AnyPublisher<[Crime], PoliceDataError> {
        apiClient.get(endpoint: CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimesAtLocationPublisher(atCoordinate coordinate: Coordinate,
                                   date: Date?) -> AnyPublisher<[Crime], PoliceDataError> {
        apiClient.get(endpoint: CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func categoriesPublisher(date: Date) -> AnyPublisher<[CrimeCategory], PoliceDataError> {
        apiClient.get(endpoint: CrimesEndpoint.categories(date: date))
    }

}
#endif
