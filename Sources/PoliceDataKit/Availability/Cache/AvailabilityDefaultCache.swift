//
//  AvailabilityDefaultCache.swift
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
