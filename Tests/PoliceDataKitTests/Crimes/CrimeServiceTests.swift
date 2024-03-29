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

import Combine
import MapKit
@testable import PoliceDataKit
import XCTest

// swiftlint:disable:next type_body_length
final class CrimeServiceTests: XCTestCase {

    var service: CrimeService!
    var apiClient: MockAPIClient!
    var cache: CrimeMockCache!
    var availableDataRegion: MKCoordinateRegion!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = CrimeMockCache()
        availableDataRegion = .test
        cancellables = Set<AnyCancellable>()
        service = CrimeService(apiClient: apiClient, cache: cache, availableDataRegion: availableDataRegion)
    }

    override func tearDown() {
        service = nil
        cancellables = nil
        availableDataRegion = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testStreetLevelCrimesAtCoordinateReturnsCrimes() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.add(response: .success(Crime.mocks))

        let result = try await service.streetLevelCrimes(at: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date).path
        )
    }

    func testStreetLevelCrimesPublisherAtCoordinateReturnsCrimes() {
        let coordinate = CLLocationCoordinate2D.mock
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.add(response: .success(Crime.mocks))

        let expectation = expectation(description: "StreetLevelCrimesPublisher")
        var result: [Crime]?
        service.streetLevelCrimesPublisher(at: coordinate, date: date)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { crimes in
                result = crimes
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date).path
        )
    }

    func testStreetLevelCrimesAtCoordsWhenOutsideDataRegionThrowsLocationOutsideOfDataSetRegionError() async throws {
        let coordinate = CLLocationCoordinate2D.outsideAvailableDataRegion
        let date = Date()
        apiClient.add(response: .success(Crime.mocks))

        var resultError: CrimeError?
        do {
            _ = try await service.streetLevelCrimes(at: coordinate, date: date)
        } catch let error as CrimeError {
            resultError = error
        }

        XCTAssertEqual(resultError, .locationOutsideOfDataSetRegion)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testStreetLevelCrimesInAreaReturnsCrimes() async throws {
        let coordinates = CLLocationCoordinate2D.mocks
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.add(response: .success(Crime.mocks))

        let result = try await service.streetLevelCrimes(in: coordinates, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            CrimesEndpoint.streetLevelCrimesInArea(coordinates: CLLocationCoordinate2D.mocks, date: date).path
        )
    }

    func testStreetLevelCrimesPublisherInAreaReturnsCrimes() {
        let coordinates = CLLocationCoordinate2D.mocks
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.add(response: .success(Crime.mocks))

        let expectation = expectation(description: "StreetLevelCrimesPublisher")
        var result: [Crime]?
        service.streetLevelCrimesPublisher(in: coordinates, date: date)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { crimes in
                result = crimes
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            CrimesEndpoint.streetLevelCrimesInArea(coordinates: CLLocationCoordinate2D.mocks, date: date).path
        )
    }

    func testCrimesForStreetWhenNotCachedReturnsCrimes() async throws {
        let expectedResult = Crime.mocks
        let streetID = try XCTUnwrap(expectedResult[0].location?.street.id)
        let date = Date()
        apiClient.add(response: .success(Crime.mocks))

        let result = try await service.crimes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date).path
        )
    }

    func testCrimesForStreetWhenCachedReturnsCachedCrimes() async throws {
        let expectedResult = Crime.mocks
        let streetID = try XCTUnwrap(expectedResult[0].location?.street.id)
        let date = Date()
        await cache.setCrimes(expectedResult, forStreet: streetID, date: date)

        let result = try await service.crimes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testCrimesForStreetWhenNotCachedAndReturnsCrimesShouldCacheResult() async throws {
        let expectedResult = Crime.mocks
        let streetID = try XCTUnwrap(expectedResult[0].location?.street.id)
        let date = Date()
        apiClient.add(response: .success(Crime.mocks))
        _ = try await service.crimes(forStreet: streetID, date: date)

        let cachedResult = await cache.crimes(forStreet: streetID, date: date)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testCrimesAtCoordinateReturnsCrimes() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.add(response: .success(Crime.mocks))

        let result = try await service.crimes(at: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date).path
        )
    }

    func testCrimesPublisherAtCoordinateReturnsCrimes() {
        let coordinate = CLLocationCoordinate2D.mock
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.add(response: .success(Crime.mocks))

        let expectation = expectation(description: "StreetLevelCrimesPublisher")
        var result: [Crime]?
        service.crimesPublisher(at: coordinate, date: date)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { crimes in
                result = crimes
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date).path
        )
    }

    func testCrimesAtCoordsWhenNotInAvailableDataRegionThrowsLocationOutsideOfDataSetRegionError() async throws {
        let coordinate = CLLocationCoordinate2D.outsideAvailableDataRegion
        let date = Date()
        apiClient.add(response: .success(Crime.mocks))

        var resultError: CrimeError?
        do {
            _ = try await service.crimes(at: coordinate, date: date)
        } catch let error as CrimeError {
            resultError = error
        }

        XCTAssertEqual(resultError, .locationOutsideOfDataSetRegion)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testCrimesWithNoLocationWhenNotCachedReturnsCrimes() async throws {
        let category = CrimeCategory.mock
        let categoryID = category.id
        let policeForceID = PoliceForce.mock.id
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.add(response: .success(Crime.mocks))

        let result = try await service.crimesWithNoLocation(
            forCategory: categoryID,
            inPoliceForce: policeForceID,
            date: date
        )

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID, date: date).path
        )
    }

    func testCrimesWithNoLocationWhenCachedReturnsCachedCrimes() async throws {
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

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testCrimesWithNoLocationWhenNotCachedAndReturnsCrimesShouldCacheResult() async throws {
        let category = CrimeCategory.mock
        let categoryID = category.id
        let policeForceID = PoliceForce.mock.id
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.add(response: .success(Crime.mocks))
        _ = try await service.crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.crimesWithNoLocation(
            forCategory: categoryID,
            inPoliceForce: policeForceID,
            date: date
        )

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testCrimeCategoriesWhenNotCachedReturnsCrimeCategories() async throws {
        let expectedResult = CrimeCategory.mocks
        let date = Date()
        apiClient.add(response: .success(CrimeCategory.mocks))

        let result = try await service.crimeCategories(forDate: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(apiClient.requestedURLs.last, CrimesEndpoint.categories(date: date).path)
    }

    func testCrimeCategoriesWhenCachedReturnsCachedCrimeCategories() async throws {
        let expectedResult = CrimeCategory.mocks
        let date = Date()
        await cache.setCrimeCategories(expectedResult, forDate: date)

        let result = try await service.crimeCategories(forDate: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testCrimeCategoriesWhenNotCachedReturnsCrimeCategoriesShouldCacheResult() async throws {
        let expectedResult = CrimeCategory.mocks
        let date = Date()
        apiClient.add(response: .success(CrimeCategory.mocks))
        _ = try await service.crimeCategories(forDate: date)

        let cachedResult = await cache.crimeCategories(forDate: date)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
