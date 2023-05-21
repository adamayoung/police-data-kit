import Foundation
@testable import PoliceDataKit

final class StopAndSearchMockCache: StopAndSearchCache {

    private var cacheStore: [String: Any] = [:]

    private enum CacheKey {

        static func stopAndSearches(streetID: Int, date: Date) -> String {
            "stop-and-searches-location-\(streetID)-\(date)"
        }

        static func stopAndSearchesWithNoLocation(policeForceID: PoliceForce.ID, date: Date) -> String {
            "stop-and-searches-no-location-\(policeForceID)-\(date)"
        }

        static func stopAndSearches(policeForceID: PoliceForce.ID, date: Date) -> String {
            "stop-and-searches-police-force-\(policeForceID)-\(date)"
        }

    }

    func stopAndSearches(atLocation streetID: Int, date: Date) async -> [StopAndSearch]? {
        cacheStore[CacheKey.stopAndSearches(streetID: streetID, date: date)] as? [StopAndSearch]
    }

    func setStopAndSearches(_ stopAndSearches: [StopAndSearch], atLocation streetID: Int, date: Date) async {
        cacheStore[CacheKey.stopAndSearches(streetID: streetID, date: date)] = stopAndSearches
    }

    func stopAndSearchesWithNoLocation(forPoliceForce policeForceID: PoliceForce.ID,
                                       date: Date) async -> [StopAndSearch]? {
        cacheStore[CacheKey.stopAndSearchesWithNoLocation(policeForceID: policeForceID, date: date)] as? [StopAndSearch]
    }

    func setStopAndSearchesWithNoLocation(_ stopAndSearches: [StopAndSearch],
                                          forPoliceForce policeForceID: PoliceForce.ID, date: Date) async {
        cacheStore[CacheKey.stopAndSearchesWithNoLocation(policeForceID: policeForceID, date: date)] = stopAndSearches
    }

    func stopAndSearches(forPoliceForce policeForceID: PoliceForce.ID, date: Date) async -> [StopAndSearch]? {
        cacheStore[CacheKey.stopAndSearches(policeForceID: policeForceID, date: date)] as? [StopAndSearch]
    }

    func setStopAndSearches(_ stopAndSearches: [StopAndSearch], forPoliceForce policeForceID: PoliceForce.ID,
                            date: Date) async {
        cacheStore[CacheKey.stopAndSearches(policeForceID: policeForceID, date: date)] = stopAndSearches
    }

}
