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

    func fetchCrimes(forStreet streetID: Int, date: Date?,
                     completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date),
                      completion: completion)
    }

    func fetchCrimes(atCoordinate coordinate: Coordinate, date: Date?,
                     completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date),
                      completion: completion)
    }

    func fetchCrimesWithNoLocation(forCategory categoryID: String, inPoliceForce policeForceID: String, date: Date?,
                                   completion: @escaping (_ result: Result<[Crime], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID,
                                                                    policeForceID: policeForceID, date: date),
                      completion: completion)
    }

    func fetchCrimeCategories(forDate date: Date,
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
    func crimesPublisher(forStreet streetID: Int, date: Date?) -> AnyPublisher<[Crime], PoliceDataError> {
        apiClient.get(endpoint: CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimesPublisher(atCoordinate coordinate: Coordinate, date: Date?) -> AnyPublisher<[Crime], PoliceDataError> {
        apiClient.get(endpoint: CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimesWithNoLocationPublisher(forCategory categoryID: String, inPoliceForce policeForceID: String,
                                       date: Date?) -> AnyPublisher<[Crime], PoliceDataError> {
        apiClient.get(endpoint: CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID,
                                                                    policeForceID: policeForceID, date: date))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func crimeCategoriesPublisher(forDate date: Date) -> AnyPublisher<[CrimeCategory], PoliceDataError> {
        apiClient.get(endpoint: CrimesEndpoint.categories(date: date))
    }

}
#endif
