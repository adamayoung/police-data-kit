//
//  CrimeDefaultCacheTests.swift
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
@testable import PoliceDataKit
import Testing

@Suite("CrimeDefaultCache")
struct CrimeDefaultCacheTests {

    let cache: CrimeDefaultCache
    let cacheStore: MockCache

    init() {
        self.cacheStore = MockCache()
        self.cache = CrimeDefaultCache(cacheStore: cacheStore)
    }

    @Test("crimes for street when miss returns nil")
    func crimesForStreetWhenMissReturnsNil() async {
        let streetID = 1
        let date = Date()

        let result = await cache.crimes(forStreet: streetID, date: date)

        #expect(result == nil)
    }

    @Test("crimes for street when hit returns crimes")
    func crimesForStreetWhenHitReturnsCrimes() async {
        let streetID = 1
        let date = Date()
        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)
        let expectedResult = Crime.mocks
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.crimes(forStreet: streetID, date: date)

        #expect(result == expectedResult)
    }

    @Test("setCrimes for street sets crimes")
    func setCrimesForStreetSetsCrimes() async {
        let streetID = 1
        let date = Date()
        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)
        let expectedResult = Crime.mocks

        await cache.setCrimes(expectedResult, forStreet: streetID, date: date)
        let result = await cacheStore.object(for: cacheKey, type: [Crime].self)

        #expect(result == expectedResult)
    }

    @Test("crimes with no location when miss returns nil")
    func crimesWithNoLocationWhenMissReturnsNil() async {
        let categoryID = "test-crime"
        let policeForceID = "test-police-force"
        let date = Date()

        let result = await cache.crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID, date: date)

        #expect(result == nil)
    }

    @Test("crimes with no location when hit returns crimes")
    func crimesWithNoLocationWhenHitReturnsCrimes() async {
        let categoryID = "test-crime"
        let policeForceID = "test-police-force"
        let date = Date()
        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(
            categoryID: categoryID,
            policeForceID: policeForceID,
            date: date
        )
        let expectedResult = Crime.mocks
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID, date: date)

        #expect(result == expectedResult)
    }

    @Test("setCrimesWithNoLocation sets crimes")
    func crimesWithNoLocationSetsCrimes() async {
        let categoryID = "test-crime"
        let policeForceID = "test-police-force"
        let date = Date()
        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(
            categoryID: categoryID,
            policeForceID: policeForceID,
            date: date
        )
        let expectedResult = Crime.mocks

        await cache.setCrimesWithNoLocation(
            expectedResult,
            forCategory: categoryID,
            inPoliceForce: policeForceID,
            date: date
        )
        let result = await cacheStore.object(for: cacheKey, type: [Crime].self)

        #expect(result == expectedResult)
    }

    @Test("crime categories when miss returns nil")
    func crimeCategoriesWhenMissReturnsNil() async {
        let date = Date()

        let result = await cache.crimeCategories(forDate: date)

        #expect(result == nil)
    }

    @Test("crime categories when hit returns crime categories")
    func crimeCategoriesWhenHitReturnsCrimeCategories() async {
        let date = Date()
        let cacheKey = CrimeCategoriesCachingKey(date: date)
        let expectedResult = CrimeCategory.mocks
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.crimeCategories(forDate: date)

        #expect(result == expectedResult)
    }

    @Test("setCrimeCategories sets crime categories")
    func setCrimeCategoriesSetsCrimeCategories() async {
        let date = Date()
        let cacheKey = CrimeCategoriesCachingKey(date: date)
        let expectedResult = CrimeCategory.mocks

        await cache.setCrimeCategories(expectedResult, forDate: date)
        let result = await cacheStore.object(for: cacheKey, type: [CrimeCategory].self)

        #expect(result == expectedResult)
    }

}
