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
        apiClient.get(endpoint: CrimesEndpoint.streetLevelAtSpecificPoint(coordinate: coordinate, date: date),
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
        apiClient.get(endpoint: CrimesEndpoint.streetLevelAtSpecificPoint(coordinate: coordinate, date: date))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func categoriesPublisher(date: Date) -> AnyPublisher<[CrimeCategory], PoliceDataError> {
        apiClient.get(endpoint: CrimesEndpoint.categories(date: date))
    }

}
#endif