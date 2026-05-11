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
import Testing

@Suite("Police force service")
struct PoliceForceServiceTests {

    let service: PoliceForceService
    let apiClient: MockAPIClient
    let cache: PoliceForceMockCache

    init() {
        self.apiClient = MockAPIClient()
        self.cache = PoliceForceMockCache()
        self.service = PoliceForceService(apiClient: apiClient, cache: cache)
    }

    @Test("police forces when not cached returns police force references")
    func policeForcesWhenNotCachedReturnsPoliceForceReferences() async throws {
        let expectedResult = PoliceForceReference.mocks
        await apiClient.add(response: .success(PoliceForceReference.mocks))

        let result = try await service.policeForces()

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == PoliceForcesEndpoint.list.path)
    }

    @Test("police forces when cached returns cached police force references")
    func policeForcesWhenCachedReturnsCachedPoliceForceReferences() async throws {
        let expectedResult = PoliceForceReference.mocks
        await cache.setPoliceForces(expectedResult)

        let result = try await service.policeForces()

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("police forces when not cached and returns police force references should cache result")
    func policeForcesWhenNotCachedAndReturnsPoliceForceReferencesShouldCacheResult() async throws {
        let expectedResult = PoliceForceReference.mocks
        await apiClient.add(response: .success(PoliceForceReference.mocks))
        _ = try await service.policeForces()

        let cachedResult = await cache.policeForces()

        #expect(cachedResult == expectedResult)
    }

    @Test("police force when not cached returns police force")
    func policeForceWhenNotCachedReturnsPoliceForce() async throws {
        let expectedResult = PoliceForce.mock
        let id = expectedResult.id
        await apiClient.add(response: .success(PoliceForce.mock))

        let result = try await service.policeForce(withID: id)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == PoliceForcesEndpoint.details(id: id).path)
    }

    @Test("police force when not cached and not found throws notFound error")
    func policeForceWhenNotCachedAndNotFoundThrowsNotFoundError() async throws {
        let id = "leicestershire"
        await apiClient.add(response: .failure(APIClientError.notFound))

        var resultError: PoliceForceError?
        do {
            _ = try await service.policeForce(withID: id)
        } catch {
            resultError = error
        }

        #expect(resultError == .notFound)
    }

    @Test("police force when cached returns cached police force")
    func policeForceWhenCachedReturnsCachedPoliceForce() async throws {
        let expectedResult = PoliceForce.mock
        let id = expectedResult.id
        await cache.setPoliceForce(expectedResult, withID: id)

        let result = try await service.policeForce(withID: id)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("police force when not cached and returns police force should cache result")
    func policeForceWhenNotCachedAndReturnsPoliceForceShouldCacheResult() async throws {
        let expectedResult = PoliceForce.mock
        let id = expectedResult.id
        await apiClient.add(response: .success(PoliceForce.mock))
        _ = try await service.policeForce(withID: id)

        let cachedResult = await cache.policeForce(withID: id)

        #expect(cachedResult == expectedResult)
    }

    @Test("senior officers when not cached returns police officers")
    func fetchSeniorOfficersWhenNotCachedReturnsPoliceOfficers() async throws {
        let expectedResult = PoliceOfficer.mocks
        let policeForceID = "leicestershire"
        await apiClient.add(response: .success(PoliceOfficer.mocks))

        let result = try await service.seniorOfficers(inPoliceForce: policeForceID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID).path)
    }

    @Test("senior officers when not cached and police force not found throws notFound error")
    func fetchSeniorOfficersWhenNotCachedAndPoliceForceNotFoundThrowsNotFoundError() async throws {
        let policeForceID = "leicestershire"
        await apiClient.add(response: .failure(APIClientError.notFound))

        var resultError: PoliceForceError?
        do {
            _ = try await service.seniorOfficers(inPoliceForce: policeForceID)
        } catch {
            resultError = error
        }

        #expect(resultError == .notFound)
    }

    @Test("senior officers when cached returns cached police officers")
    func fetchSeniorOfficersWhenCachedReturnsCachedPoliceOfficers() async throws {
        let expectedResult = PoliceOfficer.mocks
        let policeForceID = "leicestershire"
        await cache.setSeniorOfficers(expectedResult, inPoliceForce: policeForceID)

        let result = try await service.seniorOfficers(inPoliceForce: policeForceID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("senior officers when not cached and returns police officers should cache result")
    func fetchSeniorOfficersWhenNotCachedAndReturnsPoliceOfficersShouldCacheResult() async throws {
        let expectedResult = PoliceOfficer.mocks
        let policeForceID = "leicestershire"
        await apiClient.add(response: .success(PoliceOfficer.mocks))
        _ = try await service.seniorOfficers(inPoliceForce: policeForceID)

        let cachedResult = await cache.seniorOfficers(inPoliceForce: policeForceID)

        #expect(cachedResult == expectedResult)
    }

}
