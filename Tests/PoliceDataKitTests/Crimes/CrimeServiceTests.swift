//
//  CrimeServiceTests.swift
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

@Suite("Crime service")
struct CrimeServiceTests {

    let service: CrimeService
    let apiClient: MockAPIClient
    let cache: CrimeMockCache
    let availableDataRegion: AvailableRegion

    init() {
        self.apiClient = MockAPIClient()
        self.cache = CrimeMockCache()
        self.availableDataRegion = .test
        self.service = CrimeService(apiClient: apiClient, cache: cache, availableDataRegion: availableDataRegion)
    }

    @Test("street level crimes at coordinate returns crimes")
    func streetLevelCrimesAtCoordinateReturnsCrimes() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let date = Date()
        let expectedResult = Crime.mocks
        await apiClient.add(response: .success(Crime.mocks))

        let result = try await service.streetLevelCrimes(at: coordinate, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date).path)
    }

    @Test("street level crimes at coords when outside data region throws locationOutsideOfDataSetRegion error")
    func streetLevelCrimesAtCoordsWhenOutsideDataRegionThrowsLocationOutsideOfDataSetRegionError() async throws {
        let coordinate = CLLocationCoordinate2D.outsideAvailableDataRegion
        let date = Date()
        await apiClient.add(response: .success(Crime.mocks))

        var resultError: CrimeError?
        do {
            _ = try await service.streetLevelCrimes(at: coordinate, date: date)
        } catch {
            resultError = error
        }

        #expect(resultError == .locationOutsideOfDataSetRegion)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("street level crimes in area returns crimes")
    func streetLevelCrimesInAreaReturnsCrimes() async throws {
        let coordinates = CLLocationCoordinate2D.mocks
        let date = Date()
        let expectedResult = Crime.mocks
        await apiClient.add(response: .success(Crime.mocks))

        let result = try await service.streetLevelCrimes(in: coordinates, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        let expectedPath = CrimesEndpoint.streetLevelCrimesInArea(
            coordinates: CLLocationCoordinate2D.mocks,
            date: date
        ).path
        #expect(lastURL == expectedPath)
    }

    @Test("crimes for street when not cached returns crimes")
    func crimesForStreetWhenNotCachedReturnsCrimes() async throws {
        let expectedResult = Crime.mocks
        let streetID = try #require(expectedResult[0].location?.street.id)
        let date = Date()
        await apiClient.add(response: .success(Crime.mocks))

        let result = try await service.crimes(forStreet: streetID, date: date)

        #expect(result == expectedResult)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date).path)
    }

    @Test("crimes for street when cached returns cached crimes")
    func crimesForStreetWhenCachedReturnsCachedCrimes() async throws {
        let expectedResult = Crime.mocks
        let streetID = try #require(expectedResult[0].location?.street.id)
        let date = Date()
        await cache.setCrimes(expectedResult, forStreet: streetID, date: date)

        let result = try await service.crimes(forStreet: streetID, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("crimes for street when not cached and returns crimes should cache result")
    func crimesForStreetWhenNotCachedAndReturnsCrimesShouldCacheResult() async throws {
        let expectedResult = Crime.mocks
        let streetID = try #require(expectedResult[0].location?.street.id)
        let date = Date()
        await apiClient.add(response: .success(Crime.mocks))
        _ = try await service.crimes(forStreet: streetID, date: date)

        let cachedResult = await cache.crimes(forStreet: streetID, date: date)

        #expect(cachedResult == expectedResult)
    }

    @Test("crimes at coordinate returns crimes")
    func crimesAtCoordinateReturnsCrimes() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let date = Date()
        let expectedResult = Crime.mocks
        await apiClient.add(response: .success(Crime.mocks))

        let result = try await service.crimes(at: coordinate, date: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date).path)
    }

    @Test("crimes at coords when not in available data region throws locationOutsideOfDataSetRegion error")
    func crimesAtCoordsWhenNotInAvailableDataRegionThrowsLocationOutsideOfDataSetRegionError() async throws {
        let coordinate = CLLocationCoordinate2D.outsideAvailableDataRegion
        let date = Date()
        await apiClient.add(response: .success(Crime.mocks))

        var resultError: CrimeError?
        do {
            _ = try await service.crimes(at: coordinate, date: date)
        } catch {
            resultError = error
        }

        #expect(resultError == .locationOutsideOfDataSetRegion)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("crimes with no location when not cached returns crimes")
    func crimesWithNoLocationWhenNotCachedReturnsCrimes() async throws {
        let category = CrimeCategory.mock
        let categoryID = category.id
        let policeForceID = PoliceForce.mock.id
        let date = Date()
        let expectedResult = Crime.mocks
        await apiClient.add(response: .success(Crime.mocks))

        let result = try await service.crimesWithNoLocation(
            forCategory: categoryID,
            inPoliceForce: policeForceID,
            date: date
        )

        #expect(result == expectedResult)
        let lastURL = await apiClient.requestedURLs.last
        #expect(
            lastURL == CrimesEndpoint.crimesWithNoLocation(
                categoryID: categoryID,
                policeForceID: policeForceID,
                date: date
            ).path
        )
    }

    @Test("crimes with no location when cached returns cached crimes")
    func crimesWithNoLocationWhenCachedReturnsCachedCrimes() async throws {
        let category = CrimeCategory.mock
        let categoryID = category.id
        let policeForceID = PoliceForce.mock.id
        let date = Date()
        let expectedResult = Crime.mocks
        await cache.setCrimesWithNoLocation(
            expectedResult,
            forCategory: categoryID,
            inPoliceForce: policeForceID,
            date: date
        )

        let result = try await service.crimesWithNoLocation(
            forCategory: categoryID,
            inPoliceForce: policeForceID,
            date: date
        )

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("crimes with no location when not cached and returns crimes should cache result")
    func crimesWithNoLocationWhenNotCachedAndReturnsCrimesShouldCacheResult() async throws {
        let category = CrimeCategory.mock
        let categoryID = category.id
        let policeForceID = PoliceForce.mock.id
        let date = Date()
        let expectedResult = Crime.mocks
        await apiClient.add(response: .success(Crime.mocks))
        _ = try await service.crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.crimesWithNoLocation(
            forCategory: categoryID,
            inPoliceForce: policeForceID,
            date: date
        )

        #expect(cachedResult == expectedResult)
    }

}

// MARK: - Crime categories and latest data date

extension CrimeServiceTests {

    @Test("crime categories when not cached returns crime categories")
    func crimeCategoriesWhenNotCachedReturnsCrimeCategories() async throws {
        let expectedResult = CrimeCategory.mocks
        let date = Date()
        await apiClient.add(response: .success(CrimeCategory.mocks))

        let result = try await service.crimeCategories(forDate: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == CrimesEndpoint.categories(date: date).path)
    }

    @Test("crime categories when cached returns cached crime categories")
    func crimeCategoriesWhenCachedReturnsCachedCrimeCategories() async throws {
        let expectedResult = CrimeCategory.mocks
        let date = Date()
        await cache.setCrimeCategories(expectedResult, forDate: date)

        let result = try await service.crimeCategories(forDate: date)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("crime categories when not cached returns crime categories should cache result")
    func crimeCategoriesWhenNotCachedReturnsCrimeCategoriesShouldCacheResult() async throws {
        let expectedResult = CrimeCategory.mocks
        let date = Date()
        await apiClient.add(response: .success(CrimeCategory.mocks))
        _ = try await service.crimeCategories(forDate: date)

        let cachedResult = await cache.crimeCategories(forDate: date)

        #expect(cachedResult == expectedResult)
    }

    @Test("latestDataDate when cached returns cached date")
    func latestDataDateWhenCachedReturnsCachedDate() async throws {
        let expectedDate = Date(timeIntervalSince1970: 1_759_190_400) // 2025-09-30
        await cache.setLatestDataDate(expectedDate)

        let result = try await service.latestDataDate()

        #expect(result == expectedDate)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("latestDataDate when not cached returns date")
    func latestDataDateWhenNotCachedReturnsDate() async throws {
        let expectedDate = Date(timeIntervalSince1970: 1_759_190_400) // 2025-09-30
        let mockDTO = LastUpdatedDTO.mock(date: expectedDate)
        await apiClient.add(response: .success(mockDTO))

        let result = try await service.latestDataDate()

        #expect(result == expectedDate)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == CrimesEndpoint.lastUpdated.path)
    }

    @Test("latestDataDate when not cached should cache result")
    func latestDataDateWhenNotCachedShouldCacheResult() async throws {
        let expectedDate = Date(timeIntervalSince1970: 1_759_190_400)
        let mockDTO = LastUpdatedDTO.mock(date: expectedDate)
        await apiClient.add(response: .success(mockDTO))
        _ = try await service.latestDataDate()

        let cachedDate = await cache.latestDataDate()

        #expect(cachedDate == expectedDate)
    }

    @Test("latestDataDate when network error throws network error")
    func latestDataDateWhenNetworkErrorThrowsNetworkError() async throws {
        let networkError = URLError(.notConnectedToInternet)
        await apiClient.add(response: .failure(APIClientError.network(networkError)))

        var resultError: CrimeError?
        do {
            _ = try await service.latestDataDate()
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

    @Test("latestDataDate when decode error throws unknown error")
    func latestDataDateWhenDecodeErrorThrowsUnknownError() async throws {
        let decodeError = DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "bad"))
        await apiClient.add(response: .failure(APIClientError.decode(decodeError)))

        var resultError: CrimeError?
        do {
            _ = try await service.latestDataDate()
        } catch {
            resultError = error
        }

        #expect(resultError == .unknown)
    }

}
