import Foundation

#if canImport(Combine)
import Combine
#endif

final class UKStopAndSearchesService: StopAndSearchesService {

    private let apiClient: APIClient

    init(apiClient: APIClient = PoliceDataAPIClient.shared) {
        self.apiClient = apiClient
    }

    func fetchStopAndSearchesByArea(
        atCoordinate coordinate: Coordinate, date: Date?,
        completion: @escaping (_ result: Result<[StopAndSearch], PoliceDataError>) -> Void
    ) {
        apiClient.get(endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate,
                                                                                             date: date),
                      completion: completion)
    }

}

#if canImport(Combine)
extension UKStopAndSearchesService {

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func stopAndSearchesByAreaPublisher(atCoordinate coordinate: Coordinate,
                                        date: Date?) -> AnyPublisher<[StopAndSearch], PoliceDataError> {
        apiClient.get(endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate,
                                                                                             date: date))
    }

}
#endif
