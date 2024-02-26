//
//  StopAndSearchDefaultCache.swift
//  PoliceDataKit
//
//  Copyright © 2024 Adam Young.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an AS IS BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

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

    func setStopAndSearches(
        _ stopAndSearches: [StopAndSearch],
        atLocation streetID: Int,
        date: Date
    ) async {
        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)

        await cacheStore.set(stopAndSearches, for: cacheKey)
    }

    func stopAndSearchesWithNoLocation(
        forPoliceForce policeForceID: PoliceForce.ID,
        date: Date
    ) async -> [StopAndSearch]? {
        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)
        let cachedStopAndSearches = await cacheStore.object(for: cacheKey, type: [StopAndSearch].self)

        return cachedStopAndSearches
    }

    func setStopAndSearchesWithNoLocation(
        _ stopAndSearches: [StopAndSearch],
        forPoliceForce policeForceID: PoliceForce.ID,
        date: Date
    ) async {
        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)

        await cacheStore.set(stopAndSearches, for: cacheKey)
    }

    func stopAndSearches(forPoliceForce policeForceID: PoliceForce.ID, date: Date) async -> [StopAndSearch]? {
        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)
        let cachedStopAndSearches = await cacheStore.object(for: cacheKey, type: [StopAndSearch].self)

        return cachedStopAndSearches
    }

    func setStopAndSearches(
        _ stopAndSearches: [StopAndSearch],
        forPoliceForce policeForceID: PoliceForce.ID,
        date: Date
    ) async {
        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)

        await cacheStore.set(stopAndSearches, for: cacheKey)
    }

}
