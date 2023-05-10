import Foundation

final class AvailabilityDefaultCache: AvailabilityCache {

    private let cacheStore: any Cache

    init(cacheStore: some Cache) {
        self.cacheStore = cacheStore
    }

    func availableDataSets() async -> [DataSet]? {
        let cacheKey = AvailableDataSetsCachingKey()
        let cachedDataSets = await cacheStore.object(for: cacheKey, type: [DataSet].self)

        return cachedDataSets
    }

    func setAvailableDataSets(_ dataSets: [DataSet]) async {
        let cacheKey = AvailableDataSetsCachingKey()

        await cacheStore.set(dataSets, for: cacheKey)
    }

}
