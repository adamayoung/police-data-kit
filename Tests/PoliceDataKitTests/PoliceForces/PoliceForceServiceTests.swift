//
//  PoliceForceServiceTests.swift
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

final class PoliceForceServiceTests: XCTestCase {

    var service: PoliceForceService!
    var apiClient: MockAPIClient!
    var cache: PoliceForceMockCache!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = PoliceForceMockCache()
        service = PoliceForceService(apiClient: apiClient, cache: cache)
    }

    override func tearDown() {
        service = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testPoliceForcesWhenNotCachedReturnsPoliceForceReferences() async throws {
        let expectedResult = PoliceForceReference.mocks
        apiClient.add(response: .success(PoliceForceReference.mocks))

        let result = try await service.policeForces()

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(apiClient.requestedURLs.last, PoliceForcesEndpoint.list.path)
    }

    func testPoliceForcesWhenCachedReturnsCachedPoliceForceReferences() async throws {
        let expectedResult = PoliceForceReference.mocks
        await cache.setPoliceForces(expectedResult)

        let result = try await service.policeForces()

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testPoliceForcesWhenNotCachedAndReturnsPoliceForceReferencesShouldCacheResult() async throws {
        let expectedResult = PoliceForceReference.mocks
        apiClient.add(response: .success(PoliceForceReference.mocks))
        _ = try await service.policeForces()

        let cachedResult = await cache.policeForces()

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testPoliceForceWhenNotCachedReturnsPoliceForce() async throws {
        let expectedResult = PoliceForce.mock
        let id = expectedResult.id
        apiClient.add(response: .success(PoliceForce.mock))

        let result = try await service.policeForce(withID: id)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(apiClient.requestedURLs.last, PoliceForcesEndpoint.details(id: id).path)
    }

    func testPoliceForceWhenNotCachedAndNotFoundThrowsNotFoundError() async throws {
        let id = "leicestershire"
        apiClient.add(response: .failure(APIClientError.notFound))

        var resultError: PoliceForceError?
        do {
            _ = try await service.policeForce(withID: id)
        } catch let error as PoliceForceError {
            resultError = error
        }

        XCTAssertEqual(resultError, .notFound)
    }

    func testPoliceForceWhenCachedReturnsCachedPoliceForce() async throws {
        let expectedResult = PoliceForce.mock
        let id = expectedResult.id
        await cache.setPoliceForce(expectedResult, withID: id)

        let result = try await service.policeForce(withID: id)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testPoliceForceWhenNotCachedAndReturnsPoliceForceShouldCacheResult() async throws {
        let expectedResult = PoliceForce.mock
        let id = expectedResult.id
        apiClient.add(response: .success(PoliceForce.mock))
        _ = try await service.policeForce(withID: id)

        let cachedResult = await cache.policeForce(withID: id)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testFetchSeniorOfficersWhenNotCachedReturnsPoliceOfficers() async throws {
        let expectedResult = PoliceOfficer.mocks
        let policeForceID = "leicestershire"
        apiClient.add(response: .success(PoliceOfficer.mocks))

        let result = try await service.seniorOfficers(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 1)
        XCTAssertEqual(
            apiClient.requestedURLs.last,
            PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID).path
        )
    }

    func testFetchSeniorOfficersWhenNotCachedAndPoliceForceNotFoundThrowsNotFoundError() async throws {
        let policeForceID = "leicestershire"
        apiClient.add(response: .failure(APIClientError.notFound))

        var resultError: PoliceForceError?
        do {
            _ = try await service.seniorOfficers(inPoliceForce: policeForceID)
        } catch let error as PoliceForceError {
            resultError = error
        }

        XCTAssertEqual(resultError, .notFound)
    }

    func testFetchSeniorOfficersWhenCachedReturnsCachedPoliceOfficers() async throws {
        let expectedResult = PoliceOfficer.mocks
        let policeForceID = "leicestershire"
        await cache.setSeniorOfficers(expectedResult, inPoliceForce: policeForceID)

        let result = try await service.seniorOfficers(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.requestedURLs.count, 0)
    }

    func testFetchSeniorOfficersWhenNotCachedAndReturnsPoliceOfficersShouldCacheResult() async throws {
        let expectedResult = PoliceOfficer.mocks
        let policeForceID = "leicestershire"
        apiClient.add(response: .success(PoliceOfficer.mocks))
        _ = try await service.seniorOfficers(inPoliceForce: policeForceID)

        let cachedResult = await cache.seniorOfficers(inPoliceForce: policeForceID)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
