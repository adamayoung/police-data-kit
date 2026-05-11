//
//  NeighbourhoodServiceEventsTests.swift
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

@Suite("Neighbourhood service events")
struct NeighbourhoodServiceEventsTests {

    let service: NeighbourhoodService
    let apiClient: MockAPIClient
    let cache: NeighbourhoodMockCache
    let availableDataRegion: AvailableRegion

    init() {
        self.apiClient = MockAPIClient()
        self.cache = NeighbourhoodMockCache()
        self.availableDataRegion = .test
        self.service = NeighbourhoodService(
            apiClient: apiClient,
            cache: cache,
            availableDataRegion: availableDataRegion
        )
    }

    @Test("events when not cached returns events")
    func eventsWhenNotCachedReturnsEvents() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodEvent.mocks
        await apiClient.add(response: .success(NeighbourhoodEvent.mocks))

        let result = try await service.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(
            lastURL == NeighbourhoodsEndpoint.events(
                policeForceID: policeForceID,
                neighbourhoodID: neighbourhoodID
            ).path
        )
    }

    @Test("events when cached returns cached events")
    func eventsWhenCachedReturnsCachedEvents() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodEvent.mocks
        await cache.setEvents(expectedResult, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let result = try await service.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("events when not cached and returns events should cache result")
    func eventsWhenNotCachedAndReturnsEventsShouldCacheResult() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodEvent.mocks
        await apiClient.add(response: .success(NeighbourhoodEvent.mocks))
        _ = try await service.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(cachedResult == expectedResult)
    }

    @Test("events when not found throws notFound error")
    func eventsWhenNotFoundThrowsNotFoundError() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        await apiClient.add(response: .failure(APIClientError.notFound))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)
        } catch {
            resultError = error
        }

        #expect(resultError == .notFound)
    }

    @Test("events when network error throws network error")
    func eventsWhenNetworkErrorThrowsNetworkError() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let networkError = URLError(.notConnectedToInternet)
        await apiClient.add(response: .failure(APIClientError.network(networkError)))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)
        } catch {
            resultError = error
        }

        #expect(resultError != nil)
        if case .network = resultError {
            // pass
        } else {
            Issue.record("Expected .network error, got \(String(describing: resultError))")
        }
    }

    @Test("events when decode error throws unknown error")
    func eventsWhenDecodeErrorThrowsUnknownError() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let decodeError = DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "bad"))
        await apiClient.add(response: .failure(APIClientError.decode(decodeError)))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)
        } catch {
            resultError = error
        }

        #expect(resultError == .unknown)
    }

}
