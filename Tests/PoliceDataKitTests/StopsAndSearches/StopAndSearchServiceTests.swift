//
//  StopAndSearchServiceTests.swift
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
@testable import PoliceDataKit
import Testing

@Suite("Stop and search service")
struct StopAndSearchServiceTests {

    let service: StopAndSearchService
    let apiClient: MockAPIClient
    let cache: StopAndSearchMockCache
    let availableDataRegion: AvailableRegion

    init() {
        self.apiClient = MockAPIClient()
        self.cache = StopAndSearchMockCache()
        self.availableDataRegion = .test
        self.service = StopAndSearchService(
            apiClient: apiClient,
            cache: cache,
            availableDataRegion: availableDataRegion
        )
    }

    @Test("stop and searches at coordinate returns stop and searches")
    func stopAndSearchesAtCoordinateReturnsStopAndSearches() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await apiClient.add(response: .success(StopAndSearch.mocks))

        let result = try await service.stopAndSearches(at: coordinate, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(
            lastURL == StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(
                coordinate: .mock,
                date: date
            ).path
        )
    }

    @Test("stop and searches at coords when outside data region throws locationOutsideOfDataSetRegion error")
    func stopAndSearchesAtCoordsWhenOutsideDataRegionThrowsLocationOutsideOfDataSetRegionError() async throws {
        let coordinate = CLLocationCoordinate2D.outsideAvailableDataRegion
        let date = Date()
        await apiClient.add(response: .success(StopAndSearch.mocks))

        var resultError: StopAndSearchError?
        do {
            _ = try await service.stopAndSearches(at: coordinate, date: date)
        } catch {
            resultError = error
        }

        #expect(resultError == .locationOutsideOfDataSetRegion)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("stop and searches in area returns stop and searches")
    func stopAndSearchesInAreaReturnsStopAndSearches() async throws {
        let coordinates = CLLocationCoordinate2D.mocks
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await apiClient.add(response: .success(StopAndSearch.mocks))

        let result = try await service.stopAndSearches(in: coordinates, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(
            lastURL == StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(
                coordinates: coordinates,
                date: date
            ).path
        )
    }

    @Test("stop and searches at location when not cached returns stop and searches")
    func stopAndSearchesAtLocationWhenNotCachedReturnsStopAndSearches() async throws {
        let streetID = 123_456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await apiClient.add(response: .success(StopAndSearch.mocks))

        let result = try await service.stopAndSearches(atLocation: streetID, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(
            lastURL == StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date).path
        )
    }

    @Test("stop and searches at location when cached returns cached stop and searches")
    func stopAndSearchesAtLocationWhenCachedReturnsCachedStopAndSearches() async throws {
        let streetID = 123_456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await cache.setStopAndSearches(expectedResult, atLocation: streetID, date: date)

        let result = try await service.stopAndSearches(atLocation: streetID, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("stop and searches at location when not cached and returns stop and searches should cache result")
    func stopAndSearchesAtLocationWhenNotCachedAndReturnsStopAndSearchesShouldCacheResult() async throws {
        let streetID = 123_456
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await apiClient.add(response: .success(StopAndSearch.mocks))
        _ = try await service.stopAndSearches(atLocation: streetID, date: date)

        let cachedResult = await cache.stopAndSearches(atLocation: streetID, date: date)

        #expect(cachedResult == expectedResult)
    }

    @Test("stop and searches with no location when not cached returns stop and searches")
    func stopAndSearchesWithNoLocationWhenNotCachedReturnsStopAndSearches() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await apiClient.add(response: .success(StopAndSearch.mocks))

        let result = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(
            lastURL == StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(
                policeForceID: policeForceID,
                date: date
            ).path
        )
    }

    @Test("stop and searches with no location when cached returns cached stop and searches")
    func stopAndSearchesWithNoLocationWhenCachedReturnsCachedStopAndSearches() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await cache.setStopAndSearchesWithNoLocation(expectedResult, forPoliceForce: policeForceID, date: date)

        let result = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("stop and searches with no location when not cached and returns stop and searches should cache result")
    func stopAndSearchesWithNoLocationWhenNotCachedAndReturnsStopAndSearchesShouldCacheResult() async throws {
        let policeForceID = "cleveland"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await apiClient.add(response: .success(StopAndSearch.mocks))
        _ = try await service.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        #expect(cachedResult == expectedResult)
    }

    @Test("stop and searches for police force when not cached returns stop and searches")
    func stopAndSearchesForPoliceForceWhenNotCachedReturnsStopAndSearches() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await apiClient.add(response: .success(StopAndSearch.mocks))

        let result = try await service.stopAndSearches(forPoliceForce: policeForceID, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(
            lastURL == StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(
                policeForceID: policeForceID,
                date: date
            ).path
        )
    }

    @Test("stop and searches for police force when cached returns cached stop and searches")
    func stopAndSearchesForPoliceForceWhenCachedReturnsCachedStopAndSearches() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await cache.setStopAndSearches(expectedResult, forPoliceForce: policeForceID, date: date)

        let result = try await service.stopAndSearches(forPoliceForce: policeForceID, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("stop and searches for police force when not cached and returns stop and searches should cache result")
    func stopAndSearchesForPoliceForceWhenNotCachedAndReturnsStopAndSearchesShouldCacheResult() async throws {
        let policeForceID = "avon-and-somerset"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        await apiClient.add(response: .success(StopAndSearch.mocks))
        _ = try await service.stopAndSearches(forPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.stopAndSearches(forPoliceForce: policeForceID, date: date)

        #expect(cachedResult == expectedResult)
    }

}
