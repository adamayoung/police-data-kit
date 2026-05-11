//
//  StopAndSearchDefaultCacheTests.swift
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

@Suite("StopAndSearchDefaultCache")
struct StopAndSearchDefaultCacheTests {

    let cache: StopAndSearchDefaultCache
    let cacheStore: MockCache

    init() {
        self.cacheStore = MockCache()
        self.cache = StopAndSearchDefaultCache(cacheStore: cacheStore)
    }

    @Test("stop and searches at location when miss returns nil")
    func stopAndSearchesAtLocationWhenMissReturnsNil() async {
        let streetID = 1
        let date = Date()

        let result = await cache.stopAndSearches(atLocation: streetID, date: date)

        #expect(result == nil)
    }

    @Test("stop and searches at location when hit returns stop and searches")
    func stopAndSearchesAtLocationWhenHitReturnsStopAndSearches() async {
        let streetID = 1
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.stopAndSearches(atLocation: streetID, date: date)

        #expect(result == expectedResult)
    }

    @Test("set stop and searches at location sets stop and searches")
    func setStopAndSearchesAtLocationSetsStopAndSearches() async {
        let streetID = 1
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)

        await cache.setStopAndSearches(expectedResult, atLocation: streetID, date: date)
        let result = await cacheStore.object(for: cacheKey, type: [StopAndSearch].self)

        #expect(result == expectedResult)
    }

    @Test("stop and searches with no location when miss returns nil")
    func stopAndSearchesWithNoLocationWhenMissReturnsNil() async {
        let policeForceID = "test-police-force"
        let date = Date()

        let result = await cache.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        #expect(result == nil)
    }

    @Test("stop and searches with no location when hit returns stop and searches")
    func stopAndSearchesWithNoLocationWhenHitReturnsStopAndSearches() async {
        let policeForceID = "test-police-force"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        #expect(result == expectedResult)
    }

    @Test("set stop and searches with no location sets stop and searches")
    func setStopAndSearchesWithNoLocationSetsStopAndSearches() async {
        let policeForceID = "test-police-force"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)

        await cache.setStopAndSearchesWithNoLocation(expectedResult, forPoliceForce: policeForceID, date: date)
        let result = await cacheStore.object(for: cacheKey, type: [StopAndSearch].self)

        #expect(result == expectedResult)
    }

    @Test("stop and searches for police force when miss returns nil")
    func stopAndSearchesForPoliceForceWhenMissReturnsNil() async {
        let policeForceID = "test-police-force"
        let date = Date()

        let result = await cache.stopAndSearches(forPoliceForce: policeForceID, date: date)

        #expect(result == nil)
    }

    @Test("stop and searches for police force when hit returns stop and searches")
    func stopAndSearchesForPoliceForceWhenHitReturnsStopAndSearches() async {
        let policeForceID = "test-police-force"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.stopAndSearches(forPoliceForce: policeForceID, date: date)

        #expect(result == expectedResult)
    }

    @Test("set stop and searches for police force sets stop and searches")
    func setStopAndSearchesForPoliceForceSetsStopAndSearches() async {
        let policeForceID = "test-police-force"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)

        await cache.setStopAndSearches(expectedResult, forPoliceForce: policeForceID, date: date)
        let result = await cacheStore.object(for: cacheKey, type: [StopAndSearch].self)

        #expect(result == expectedResult)
    }

}
