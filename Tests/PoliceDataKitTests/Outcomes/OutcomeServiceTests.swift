//
//  OutcomeServiceTests.swift
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

@Suite("Outcome service")
struct OutcomeServiceTests {

    let service: OutcomeService
    let apiClient: MockAPIClient
    let cache: OutcomeMockCache
    let availableDataRegion: AvailableRegion

    init() {
        self.apiClient = MockAPIClient()
        self.cache = OutcomeMockCache()
        self.availableDataRegion = .test
        self.service = OutcomeService(apiClient: apiClient, cache: cache, availableDataRegion: availableDataRegion)
    }

    @Test("street level outcomes for street when not cached returns outcomes")
    func streetLevelOutcomesForStreetWhenNotCachedReturnsOutcomes() async throws {
        let expectedResult = Outcome.mocks
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        await apiClient.add(response: .success(Outcome.mocks))

        let result = try await service.streetLevelOutcomes(forStreet: streetID, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date).path)
    }

    @Test("street level outcomes for street when cached returns cached outcomes")
    func streetLevelOutcomesForStreetWhenCachedReturnsCachedOutcomes() async throws {
        let expectedResult = Outcome.mocks
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        await cache.setStreetLevelOutcomes(expectedResult, forStreet: streetID, date: date)

        let result = try await service.streetLevelOutcomes(forStreet: streetID, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("street level outcomes for street when not cached and returns outcomes should cache result")
    func streetLevelOutcomesForStreetWhenNotCachedAndReturnsOutcomesShouldCacheResult() async throws {
        let expectedResult = Outcome.mocks
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        await apiClient.add(response: .success(Outcome.mocks))
        _ = try await service.streetLevelOutcomes(forStreet: streetID, date: date)

        let cachedResult = await cache.streetLevelOutcomes(forStreet: streetID, date: date)

        #expect(cachedResult == expectedResult)
    }

    @Test("street level outcomes at coordinate returns outcomes")
    func streetLevelOutcomesAtCoordinateReturnsOutcomes() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let expectedResult = Outcome.mocks
        let date = Date()
        await apiClient.add(response: .success(Outcome.mocks))

        let result = try await service.streetLevelOutcomes(at: coordinate, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(
            lastURL == OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date).path
        )
    }

    @Test("street level outcomes at coords when not in available data region throws error")
    func streetLevelOutcomesAtCoordsWhenNotInAvailableDataRegionThrowsError() async throws {
        let coordinate = CLLocationCoordinate2D.outsideAvailableDataRegion
        let date = Date()
        await apiClient.add(response: .success(Outcome.mocks))

        var resultError: OutcomeError?
        do {
            _ = try await service.streetLevelOutcomes(at: coordinate, date: date)
        } catch {
            resultError = error
        }

        #expect(resultError == .locationOutsideOfDataSetRegion)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("street level outcomes in area returns outcomes")
    func streetLevelOutcomesInAreaReturnsOutcomes() async throws {
        let boundary = CLLocationCoordinate2D.mocks
        let expectedResult = Outcome.mocks
        let date = Date()
        await apiClient.add(response: .success(Outcome.mocks))

        let result = try await service.streetLevelOutcomes(in: boundary, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(
            lastURL == OutcomesEndpoint.streetLevelOutcomesInArea(
                coordinates: CLLocationCoordinate2D.mocks,
                date: date
            ).path
        )
    }

    @Test("fetch case history not cached returns case history")
    func fetchCaseHistoryNotCachedReturnsCaseHistory() async throws {
        let expectedResult = CaseHistory.mock
        let crimeID = expectedResult.crime.crimeID
        await apiClient.add(response: .success(CaseHistory.mock))

        let result = try await service.caseHistory(forCrime: crimeID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == OutcomesEndpoint.caseHistory(crimeID: crimeID).path)
    }

    @Test("fetch case history when not found throws notFound error")
    func fetchCaseHistoryWhenNotFoundThrowsNotFoundError() async throws {
        let crimeID = "123ABC"
        await apiClient.add(response: .failure(APIClientError.notFound))

        var resultError: OutcomeError?
        do {
            _ = try await service.caseHistory(forCrime: crimeID)
        } catch {
            resultError = error
        }

        #expect(resultError == .notFound)
    }

    @Test("fetch case history when cached returns cached case history")
    func fetchCaseHistoryWhenCachedReturnsCachedCaseHistory() async throws {
        let expectedResult = CaseHistory.mock
        let crimeID = expectedResult.crime.crimeID
        await cache.setCaseHistory(expectedResult, forCrime: crimeID)

        let result = try await service.caseHistory(forCrime: crimeID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("fetch case history when not cached and returns case history should cache result")
    func fetchCaseHistoryWhenNotCachedAndReturnsCaseHistoryShouldCacheResult() async throws {
        let expectedResult = CaseHistory.mock
        let crimeID = expectedResult.crime.crimeID
        await apiClient.add(response: .success(CaseHistory.mock))
        _ = try await service.caseHistory(forCrime: crimeID)

        let cachedResult = await cache.caseHistory(forCrime: crimeID)

        #expect(cachedResult == expectedResult)
    }

}
