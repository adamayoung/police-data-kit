import Foundation

#if canImport(Combine)
import Combine
#endif

final class UKStopAndSearchService: StopAndSearchService {

    private let apiClient: APIClient

    init(apiClient: APIClient = PoliceDataAPIClient.shared) {
        self.apiClient = apiClient
    }

    func fetchAll(atCoordinate coordinate: Coordinate, date: Date?,
                  completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate,
                                                                                             date: date),
                      completion: completion)
    }

    func fetchAll(atLocation streetID: Int, date: Date?,
                  completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date),
                      completion: completion)
    }

}

#if canImport(Combine)
extension UKStopAndSearchService {

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesPublisher(atCoordinate coordinate: Coordinate,
                                  date: Date?) -> AnyPublisher<[StopAndSearch], PoliceDataError> {
        apiClient.get(endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate,
                                                                                             date: date))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesPublisher(atLocation streetID: Int,
                                  date: Date?) -> AnyPublisher<[StopAndSearch], PoliceDataError> {
        apiClient.get(endpoint: StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date))
    }

}
#endif
