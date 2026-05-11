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
import Testing

@Suite("Availability service")
struct AvailabilityServiceTests {

    let service: AvailabilityService
    let apiClient: MockAPIClient
    let cache: AvailabilityMockCache

    init() {
        self.apiClient = MockAPIClient()
        self.cache = AvailabilityMockCache()
        self.service = AvailabilityService(apiClient: apiClient, cache: cache)
    }

    @Test("availableDataSets when not cached returns data sets")
    func availableDataSetsWhenNotCachedReturnsDataSets() async throws {
        let expectedResult = DataSet.mocks
        await apiClient.add(response: .success(DataSet.mocks))

        let result = try await service.availableDataSets()

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == AvailabilityEndpoint.dataSets.path)
    }

    @Test("availableDataSets when cached returns cached data sets")
    func availableDataSetsWhenCachedReturnsCachedDataSets() async throws {
        let expectedResult = DataSet.mocks
        await cache.setAvailableDataSets(expectedResult)

        let result = try await service.availableDataSets()

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("availableDataSets when not cached and returns data sets should cache result")
    func availableDataSetsWhenNotCachedAndReturnsDataSetsShouldCacheResult() async throws {
        let expectedResult = DataSet.mocks
        await apiClient.add(response: .success(DataSet.mocks))
        _ = try await service.availableDataSets()

        let cachedResult = await cache.availableDataSets()

        #expect(cachedResult == expectedResult)
    }

}
