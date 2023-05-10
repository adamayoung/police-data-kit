import Foundation
@testable import PoliceDataKit

final actor AvailabilityMockCache: AvailabilityCache {

    private var cacheStore: [String: Any] = [:]

    private enum CacheKey {
        static let availableDataSets = "availableDataSets"
    }

    func availableDataSets() async -> [DataSet]? {
        return cacheStore[CacheKey.availableDataSets] as? [DataSet]
    }

    func setAvailableDataSets(_ dataSets: [DataSet]) async {
        cacheStore[CacheKey.availableDataSets] = dataSets
    }

}
