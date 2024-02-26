//
//  CrimeDefaultCache.swift
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

import CoreLocation
import Foundation

final actor CrimeDefaultCache: CrimeCache {

    private let cacheStore: any Cache

    init(cacheStore: some Cache) {
        self.cacheStore = cacheStore
    }

    func crimes(forStreet streetID: Int, date: Date) async -> [Crime]? {
        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)
        let cachedCrimes = await cacheStore.object(for: cacheKey, type: [Crime].self)

        return cachedCrimes
    }

    func setCrimes(_ crimes: [Crime], forStreet streetID: Int, date: Date) async {
        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)

        await cacheStore.set(crimes, for: cacheKey)
    }

    func crimesWithNoLocation(
        forCategory categoryID: CrimeCategory.ID,
        inPoliceForce policeForceID: PoliceForce.ID,
        date: Date
    ) async -> [Crime]? {
        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(
            categoryID: categoryID,
            policeForceID: policeForceID,
            date: date
        )
        let cachedCrimes = await cacheStore.object(for: cacheKey, type: [Crime].self)

        return cachedCrimes
    }

    func setCrimesWithNoLocation(
        _ crimes: [Crime],
        forCategory categoryID: CrimeCategory.ID,
        inPoliceForce policeForceID: PoliceForce.ID,
        date: Date
    ) async {
        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(
            categoryID: categoryID,
            policeForceID: policeForceID,
            date: date
        )

        await cacheStore.set(crimes, for: cacheKey)
    }

    func crimeCategories(forDate date: Date) async -> [CrimeCategory]? {
        let cacheKey = CrimeCategoriesCachingKey(date: date)
        let cachedCrimeCategories = await cacheStore.object(for: cacheKey, type: [CrimeCategory].self)

        return cachedCrimeCategories
    }

    func setCrimeCategories(_ crimeCategories: [CrimeCategory], forDate date: Date) async {
        let cacheKey = CrimeCategoriesCachingKey(date: date)

        await cacheStore.set(crimeCategories, for: cacheKey)
    }

}
