//
//  AvailabilityDefaultCacheTests.swift
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

final class AvailabilityDefaultCacheTests: XCTestCase {

    var cache: AvailabilityDefaultCache!
    var cacheStore: MockCache!

    override func setUp() {
        super.setUp()
        cacheStore = MockCache()
        cache = AvailabilityDefaultCache(cacheStore: cacheStore)
    }

    override func tearDown() {
        cache = nil
        cacheStore = nil
        super.tearDown()
    }

    func testAvailableDataSetsWhenMissReturnsNil() async {
        let result = await cache.availableDataSets()

        XCTAssertNil(result)
    }

    func testAvailableDataSetsWhenHitReturnsAvailableDataSets() async {
        let cacheKey = AvailableDataSetsCachingKey()
        let expectedResult = DataSet.mocks
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.availableDataSets()

        XCTAssertEqual(result, expectedResult)
    }

    func testSetAvailableDataSetsAvailableDataSets() async {
        let cacheKey = AvailableDataSetsCachingKey()
        let expectedResult = DataSet.mocks

        await cache.setAvailableDataSets(expectedResult)
        let result = await cacheStore.object(for: cacheKey, type: [DataSet].self)

        XCTAssertEqual(result, expectedResult)
    }

}
