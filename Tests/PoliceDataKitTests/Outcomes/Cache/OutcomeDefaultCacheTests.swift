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

@testable import PoliceDataKit
import XCTest

final class OutcomeDefaultCacheTests: XCTestCase {

    var cache: OutcomeDefaultCache!
    var cacheStore: MockCache!

    override func setUp() {
        super.setUp()
        cacheStore = MockCache()
        cache = OutcomeDefaultCache(cacheStore: cacheStore)
    }

    override func tearDown() {
        cache = nil
        cacheStore = nil
        super.tearDown()
    }

    func testStreetLevelOutcomesForStreetWhenMissReturnsNil() async {
        let streetID = 1
        let date = Date()
        let result = await cache.streetLevelOutcomes(forStreet: streetID, date: date)

        XCTAssertNil(result)
    }

    func testStreetLevelOutcomesForStreetWhenHitReturnsOutcomes() async {
        let streetID = 1
        let date = Date()
        let expectedResult = Outcome.mocks
        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.streetLevelOutcomes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
    }

    func testSetStreetLevelOutcomesForStreetSetsOutcomes() async {
        let streetID = 1
        let date = Date()
        let expectedResult = Outcome.mocks
        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)

        await cache.setStreetLevelOutcomes(expectedResult, forStreet: streetID, date: date)
        let result = await cacheStore.object(for: cacheKey, type: [Outcome].self)

        XCTAssertEqual(result, expectedResult)
    }

    func testCaseHistoryWhenMissReturnsNil() async {
        let crimeID = "test-crime"
        let result = await cache.caseHistory(forCrime: crimeID)

        XCTAssertNil(result)
    }

    func testCaseHistoryWhenHitReturnsCaseHistory() async {
        let crimeID = "test-crime"
        let expectedResult = CaseHistory.mock
        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.caseHistory(forCrime: crimeID)

        XCTAssertEqual(result, expectedResult)
    }

    func testSetCaseHistorySetsCaseHistory() async {
        let crimeID = "test-crime"
        let expectedResult = CaseHistory.mock
        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)

        await cache.setCaseHistory(expectedResult, forCrime: crimeID)
        let result = await cacheStore.object(for: cacheKey, type: CaseHistory.self)

        XCTAssertEqual(result, expectedResult)
    }

}
