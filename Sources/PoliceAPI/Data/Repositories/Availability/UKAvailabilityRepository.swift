import Foundation
import os

final class UKAvailabilityRepository: AvailabilityRepository {

    private static let logger = Logger(subsystem: Logger.dataSubsystem, category: "UKAvailabilityRepository")

    private let apiClient: any APIClient
    private let cache: any Cache

    init(apiClient: some APIClient, cache: some Cache) {
        self.apiClient = apiClient
        self.cache = cache
    }

    func availableDataSets() async throws -> [DataSetDataModel] {
        Self.logger.trace("fetching available data sets")

        let cacheKey = AvailableDataSetsCachingKey()
        if let cachedDataSets = await cache.object(for: cacheKey, type: [DataSetDataModel].self) {
            return cachedDataSets
        }

        let dataSets: [DataSetDataModel]
        do {
            dataSets = try await apiClient.get(endpoint: AvailabilityEndpoint.dataSets)
        } catch let error {
            Self.logger.error("failed fetching available data sets")
            throw error
        }

        await cache.set(dataSets, for: cacheKey)

        return dataSets
    }

    func availableDataRegion() -> CoordinateRegionDataModel {
        CoordinateRegionDataModel.availableDataRegion
    }

}
