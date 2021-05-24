import Foundation

#if canImport(Combine)
import Combine
#endif

final class UKAvailabilityService: AvailabilityService {

    private let apiClient: APIClient

    init(apiClient: APIClient = PoliceDataAPIClient.shared) {
        self.apiClient = apiClient
    }

    func fetchAvailableDataSets(completion: @escaping (Result<[DataSet], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: AvailabilityEndpoint.dataSets, completion: completion)
    }

}

#if canImport(Combine)
extension UKAvailabilityService {

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func availableDataSetsPublisher() -> AnyPublisher<[DataSet], PoliceDataError> {
        apiClient.get(endpoint: AvailabilityEndpoint.dataSets)
    }

}
#endif
