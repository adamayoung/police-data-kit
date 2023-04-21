import Foundation

final class UKAvailabilityService: AvailabilityService {

    private let apiClient: any APIClient
    private let cache: any Cache

    init(apiClient: some APIClient, cache: some Cache) {
        self.apiClient = apiClient
        self.cache = cache
    }

    func availableDataSets() async throws -> [DataSet] {
        let cacheKey = AvailableDataSetsCachingKey()
        if let cachedDataSets = await cache.object(for: cacheKey, type: [DataSet].self) {
            return cachedDataSets
        }

        let dataSets: [DataSet] = try await apiClient.get(endpoint: AvailabilityEndpoint.dataSets)

        await cache.set(dataSets, for: cacheKey)

        return dataSets
    }

}
