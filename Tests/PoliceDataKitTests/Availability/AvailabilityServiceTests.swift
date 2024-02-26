//
//  AvailabilityServiceTests.swift
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

final class AvailabilityServiceTests: XCTestCase {

    var service: AvailabilityService!
    var apiClient: MockAPIClient!
    var cache: AvailabilityMockCache!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = AvailabilityMockCache()
        service = AvailabilityService(apiClient: apiClient, cache: cache)
    }

    override func tearDown() {
        service = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testAvailableDataSetsWhenNotCachedReturnsDataSets() async throws {
        let expectedResult = DataSet.mocks
        apiClient.add(response: .success(DataSet.mocks))

        let result = try await service.availableDataSets()

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(apiClient.requestedURLs.last, AvailabilityEndpoint.dataSets.path)
    }

    func testAvailableDataSetsWhenCachedReturnsCachedDataSets() async throws {
        let expectedResult = DataSet.mocks
        await cache.setAvailableDataSets(expectedResult)

        let result = try await service.availableDataSets()

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testAvailableDataSetsWhenNotCachedAndReturnsDataSetsShouldCacheResult() async throws {
        let expectedResult = DataSet.mocks
        apiClient.add(response: .success(DataSet.mocks))
        _ = try await service.availableDataSets()

        let cachedResult = await cache.availableDataSets()

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
