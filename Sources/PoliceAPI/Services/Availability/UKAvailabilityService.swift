import Foundation
import os

final class UKAvailabilityService: AvailabilityService {

    private static let logger = Logger(subsystem: Logger.subsystem, category: "AvailabilityService")

    private let apiClient: any APIClient
    private let cache: any Cache

    init(apiClient: some APIClient, cache: some Cache) {
        self.apiClient = apiClient
        self.cache = cache
    }

    func availableDataSets() async throws -> [DataSet] {
        Self.logger.trace("fetching available data sets")

        let cacheKey = AvailableDataSetsCachingKey()
        if let cachedDataSets = await cache.object(for: cacheKey, type: [DataSet].self) {
            return cachedDataSets
        }

        let dataSets: [DataSet]
        do {
            dataSets = try await apiClient.get(endpoint: AvailabilityEndpoint.dataSets)
        } catch let error {
            Self.logger.error("failed fetching available data sets")
            throw error
        }

        await cache.set(dataSets, for: cacheKey)

        return dataSets
    }

    func availableDataRegion() -> CoordinateRegion {
        CoordinateRegion.availableDataRegion
    }

}
