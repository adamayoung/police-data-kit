import Foundation

final class StopAndSearchDefaultCache: StopAndSearchCache {

    private let cacheStore: any Cache

    init(cacheStore: some Cache) {
        self.cacheStore = cacheStore
    }

    func stopAndSearches(atLocation streetID: Int, date: Date) async -> [StopAndSearch]? {
        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)
        let cachedStopAndSearches = await cacheStore.object(for: cacheKey, type: [StopAndSearch].self)

        return cachedStopAndSearches
    }

    func setStopAndSearches(_ stopAndSearches: [StopAndSearch], atLocation streetID: Int,
                            date: Date) async {
        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)

        await cacheStore.set(stopAndSearches, for: cacheKey)
    }

    func stopAndSearchesWithNoLocation(forPoliceForce policeForceID: PoliceForce.ID,
                                       date: Date) async -> [StopAndSearch]? {
        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)
        let cachedStopAndSearches = await cacheStore.object(for: cacheKey, type: [StopAndSearch].self)

        return cachedStopAndSearches
    }

    func setStopAndSearchesWithNoLocation(_ stopAndSearches: [StopAndSearch],
                                          forPoliceForce policeForceID: PoliceForce.ID, date: Date) async {
        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)

        await cacheStore.set(stopAndSearches, for: cacheKey)
    }

    func stopAndSearches(forPoliceForce policeForceID: PoliceForce.ID, date: Date) async -> [StopAndSearch]? {
        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)
        let cachedStopAndSearches = await cacheStore.object(for: cacheKey, type: [StopAndSearch].self)

        return cachedStopAndSearches
    }

    func setStopAndSearches(_ stopAndSearches: [StopAndSearch], forPoliceForce policeForceID: PoliceForce.ID,
                            date: Date) async {
        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)

        await cacheStore.set(stopAndSearches, for: cacheKey)
    }

}
