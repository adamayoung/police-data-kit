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

@testable import PoliceDataKit
import XCTest

final class NeighbourhoodServiceEventsTests: XCTestCase {

    var service: NeighbourhoodService!
    var apiClient: MockAPIClient!
    var cache: NeighbourhoodMockCache!
    var availableDataRegion: AvailableRegion!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = NeighbourhoodMockCache()
        availableDataRegion = .test
        service = NeighbourhoodService(
            apiClient: apiClient,
            cache: cache,
            availableDataRegion: availableDataRegion
        )
    }

    override func tearDown() {
        service = nil
        availableDataRegion = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testEventsWhenNotCachedReturnsEvents() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodEvent.mocks
        await apiClient.add(response: .success(NeighbourhoodEvent.mocks))

        let result = try await service.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        XCTAssertEqual(requestedURLsCount, 1)
        let lastURL = await apiClient.requestedURLs.last
        XCTAssertEqual(
            lastURL,
            NeighbourhoodsEndpoint.events(policeForceID: policeForceID, neighbourhoodID: neighbourhoodID).path
        )
    }

    func testEventsWhenCachedReturnsCachedEvents() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodEvent.mocks
        await cache.setEvents(expectedResult, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let result = try await service.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        XCTAssertEqual(requestedURLsCount, 0)
    }

    func testEventsWhenNotCachedAndReturnsEventsShouldCacheResult() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodEvent.mocks
        await apiClient.add(response: .success(NeighbourhoodEvent.mocks))
        _ = try await service.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testEventsWhenNotFoundThrowsNotFoundError() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        await apiClient.add(response: .failure(APIClientError.notFound))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)
        } catch let error as NeighbourhoodError {
            resultError = error
        }

        XCTAssertEqual(resultError, .notFound)
    }

    func testEventsWhenNetworkErrorThrowsNetworkError() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let networkError = URLError(.notConnectedToInternet)
        await apiClient.add(response: .failure(APIClientError.network(networkError)))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)
        } catch let error as NeighbourhoodError {
            resultError = error
        }

        XCTAssertNotNil(resultError)
        if case .network = resultError {} else {
            XCTFail("Expected .network error, got \(String(describing: resultError))")
        }
    }

    func testEventsWhenDecodeErrorThrowsUnknownError() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let decodeError = DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "bad"))
        await apiClient.add(response: .failure(APIClientError.decode(decodeError)))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.events(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)
        } catch let error as NeighbourhoodError {
            resultError = error
        }

        XCTAssertEqual(resultError, .unknown)
    }

}
