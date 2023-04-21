import Foundation

final class UKAvailabilityService: AvailabilityService {

    private let apiClient: any APIClient

    init(apiClient: some APIClient) {
        self.apiClient = apiClient
    }

    func availableDataSets() async throws -> [DataSet] {
        try await apiClient.get(endpoint: AvailabilityEndpoint.dataSets)
    }

}
