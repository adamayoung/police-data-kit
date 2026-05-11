//
//  OutcomeDefaultCacheTests.swift
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

@Suite("OutcomeDefaultCache")
struct OutcomeDefaultCacheTests {

    let cache: OutcomeDefaultCache
    let cacheStore: MockCache

    init() {
        self.cacheStore = MockCache()
        self.cache = OutcomeDefaultCache(cacheStore: cacheStore)
    }

    @Test("street level outcomes for street when miss returns nil")
    func streetLevelOutcomesForStreetWhenMissReturnsNil() async {
        let streetID = 1
        let date = Date()
        let result = await cache.streetLevelOutcomes(forStreet: streetID, date: date)

        #expect(result == nil)
    }

    @Test("street level outcomes for street when hit returns outcomes")
    func streetLevelOutcomesForStreetWhenHitReturnsOutcomes() async {
        let streetID = 1
        let date = Date()
        let expectedResult = Outcome.mocks
        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.streetLevelOutcomes(forStreet: streetID, date: date)

        #expect(result == expectedResult)
    }

    @Test("set street level outcomes for street sets outcomes")
    func setStreetLevelOutcomesForStreetSetsOutcomes() async {
        let streetID = 1
        let date = Date()
        let expectedResult = Outcome.mocks
        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)

        await cache.setStreetLevelOutcomes(expectedResult, forStreet: streetID, date: date)
        let result = await cacheStore.object(for: cacheKey, type: [Outcome].self)

        #expect(result == expectedResult)
    }

    @Test("case history when miss returns nil")
    func caseHistoryWhenMissReturnsNil() async {
        let crimeID = "test-crime"
        let result = await cache.caseHistory(forCrime: crimeID)

        #expect(result == nil)
    }

    @Test("case history when hit returns case history")
    func caseHistoryWhenHitReturnsCaseHistory() async {
        let crimeID = "test-crime"
        let expectedResult = CaseHistory.mock
        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.caseHistory(forCrime: crimeID)

        #expect(result == expectedResult)
    }

    @Test("set case history sets case history")
    func setCaseHistorySetsCaseHistory() async {
        let crimeID = "test-crime"
        let expectedResult = CaseHistory.mock
        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)

        await cache.setCaseHistory(expectedResult, forCrime: crimeID)
        let result = await cacheStore.object(for: cacheKey, type: CaseHistory.self)

        #expect(result == expectedResult)
    }

}
