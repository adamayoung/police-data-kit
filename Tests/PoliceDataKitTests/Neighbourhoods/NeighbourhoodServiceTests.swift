//
//  NeighbourhoodServiceTests.swift
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
@testable import PoliceDataKit
import Testing

@Suite("Neighbourhood service")
struct NeighbourhoodServiceTests {

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

    @Test("neighbours when not cached returns neighbourhood references")
    func neighboursWhenNotCachedReturnsNeighbourhoodReferences() async throws {
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodReference.mocks
        await apiClient.add(response: .success(NeighbourhoodReference.mocks))

        let result = try await service.neighbourhoods(inPoliceForce: policeForceID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == NeighbourhoodsEndpoint.list(policeForceID: policeForceID).path)
    }

    @Test("neighbours when cached returns cached neighbourhood references")
    func neighboursWhenCachedReturnsCachedNeighbourhoodReferences() async throws {
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodReference.mocks
        await cache.setNeighbourhoods(expectedResult, inPoliceForce: policeForceID)

        let result = try await service.neighbourhoods(inPoliceForce: policeForceID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("neighbours when not cached and returns neighbourhood references should cache result")
    func neighboursWhenNotCachedAndReturnsNeighbourhoodReferencesShouldCacheResult() async throws {
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodReference.mocks
        await apiClient.add(response: .success(NeighbourhoodReference.mocks))
        _ = try await service.neighbourhoods(inPoliceForce: policeForceID)

        let cachedResult = await cache.neighbourhoods(inPoliceForce: policeForceID)

        #expect(cachedResult == expectedResult)
    }

    @Test("neighbourhood when not cached returns neighbourhood")
    func neighbourhoodWhenNotCachedReturnsNeighbourhood() async throws {
        let expectedResult = Neighbourhood.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        await apiClient.add(response: .success(Neighbourhood.mock))

        let result = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID).path)
    }

    @Test("neighbourhood when not cached and not found throws notFound error")
    func neighbourhoodWhenNotCachedAndNotFoundThrowsNotFoundError() async throws {
        let id = "NC04"
        let policeForceID = "leicestershire"
        await apiClient.add(response: .failure(APIClientError.notFound))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)
        } catch {
            resultError = error
        }

        #expect(resultError == .notFound)
    }

    @Test("neighbourhood when cached returns cached neighbourhood")
    func neighbourhoodWhenCachedReturnsCachedNeighbourhood() async throws {
        let expectedResult = Neighbourhood.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        await cache.setNeighbourhood(expectedResult, withID: id, inPoliceForce: policeForceID)

        let result = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("neighbourhood when not cached and returns neighbourhood should cache result")
    func neighbourhoodWhenNotCachedAndReturnsNeighbourhoodShouldCacheResult() async throws {
        let expectedResult = Neighbourhood.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        await apiClient.add(response: .success(Neighbourhood.mock))
        _ = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        let cachedResult = await cache.neighbourhood(withID: id, inPoliceForce: policeForceID)

        #expect(cachedResult == expectedResult)
    }

    @Test("neighbourhood at coordinate returns neighbourhood")
    func neighbourhoodAtCoordinateReturnsNeighbourhood() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let neighbourhoodPolicingTeam = NeighbourhoodPolicingTeam.mock
        let expectedResult = Neighbourhood.mock

        await apiClient.add(response: .success(neighbourhoodPolicingTeam))
        await apiClient.add(response: .success(expectedResult))

        let result = try await service.neighbourhood(at: coordinate)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 2)
        let firstURL = await apiClient.requestedURLs.first
        #expect(firstURL == NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).path)
        let lastURL = await apiClient.requestedURLs.last
        #expect(
            lastURL == NeighbourhoodsEndpoint.details(
                id: neighbourhoodPolicingTeam.neighbourhood,
                policeForceID: neighbourhoodPolicingTeam.force
            ).path
        )
    }

    @Test("boundary when not cached returns boundary")
    func boundaryWhenNotCachedReturnsBoundary() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = CLLocationCoordinate2D.mocks
        await apiClient.add(response: .success(CLLocationCoordinate2D.mocks))

        let result = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(
            lastURL == NeighbourhoodsEndpoint.boundary(
                neighbourhoodID: neighbourhoodID,
                policeForceID: policeForceID
            ).path
        )
    }

    @Test("boundary when not cached and not found throws notFound error")
    func boundaryWhenNotCachedAndNotFoundThrowsNotFoundError() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        await apiClient.add(response: .failure(APIClientError.notFound))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)
        } catch {
            resultError = error
        }

        #expect(resultError == .notFound)
    }

    @Test("boundary when cached returns cached boundary")
    func boundaryWhenCachedReturnsCachedBoundary() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = CLLocationCoordinate2D.mocks
        await cache.setBoundary(expectedResult, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let result = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("boundary when not cached and returns boundary should cache result")
    func boundaryWhenNotCachedAndReturnsBoundaryShouldCacheResult() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = CLLocationCoordinate2D.mocks
        await apiClient.add(response: .success(CLLocationCoordinate2D.mocks))
        _ = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(cachedResult == expectedResult)
    }

}

// MARK: - Police officers, priorities, and policing team

extension NeighbourhoodServiceTests {

    @Test("police officers when not cached returns police officers")
    func policeOfficersWhenNotCachedReturnsPoliceOfficers() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficer.mocks
        await apiClient.add(response: .success(PoliceOfficer.mocks))

        let result = try await service.policeOfficers(
            forNeighbourhood: neighbourhoodID,
            inPoliceForce: policeForceID
        )

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(
            lastURL == NeighbourhoodsEndpoint.policeOfficers(
                neighbourhoodID: neighbourhoodID,
                policeForceID: policeForceID
            ).path
        )
    }

    @Test("police officers when cached returns cached police officers")
    func policeOfficersWhenCachedReturnsCachedPoliceOfficers() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficer.mocks
        await cache.setPoliceOfficers(expectedResult, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let result = try await service.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("police officers when not cached and returns police officers should cache result")
    func policeOfficersWhenNotCachedAndReturnsPoliceOfficersShouldCacheResult() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficer.mocks
        await apiClient.add(response: .success(PoliceOfficer.mocks))
        _ = try await service.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(cachedResult == expectedResult)
    }

    @Test("priorities when not cached returns neighbourhood priorities")
    func prioritiesWhenNotCachedReturnsNeighbourhoodPriorities() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriority.mocks
        await apiClient.add(response: .success(NeighbourhoodPriority.mocks))

        let result = try await service.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(
            lastURL == NeighbourhoodsEndpoint.priorities(
                neighbourhoodID: neighbourhoodID,
                policeForceID: policeForceID
            ).path
        )
    }

    @Test("priorities when cached returns cached neighbourhood priorities")
    func prioritiesWhenCachedReturnsCachedNeighbourhoodPriorities() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriority.mocks
        await cache.setPriorities(expectedResult, forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let result = try await service.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

    @Test("priorities when not cached and returns neighbourhood priorities should cache result")
    func prioritiesWhenNotCachedAndReturnsNeighbourhoodPrioritiesShouldCacheResult() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriority.mocks
        await apiClient.add(response: .success(NeighbourhoodPriority.mocks))
        _ = try await service.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        #expect(cachedResult == expectedResult)
    }

    @Test("neighbourhood policing team at coordinate returns neighbourhood policing team")
    func neighbourhoodPolicingTeamAtCoordinateReturnsNeighbourhoodPolicingTeam() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let expectedResult = NeighbourhoodPolicingTeam.mock
        await apiClient.add(response: .success(NeighbourhoodPolicingTeam.mock))

        let result = try await service.neighbourhoodPolicingTeam(at: coordinate)

        #expect(result == expectedResult)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 1)
        let lastURL = await apiClient.requestedURLs.last
        #expect(lastURL == NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).path)
    }

    @Test("neighbourhood policing team at coordinate when not found throws notFound error")
    func neighbourhoodPolicingTeamAtCoordinateWhenNotFoundThrowsNotFoundError() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        await apiClient.add(response: .failure(APIClientError.notFound))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.neighbourhoodPolicingTeam(at: coordinate)
        } catch {
            resultError = error
        }

        #expect(resultError == .notFound)
    }

    @Test("neighbourhood policing team at coords when not in available data region throws error")
    func neighbourhoodPolicingTeamAtCoordsWhenNotInAvailableDataRegionThrowsError() async throws {
        let coordinate = CLLocationCoordinate2D.outsideAvailableDataRegion
        let expectedResult = NeighbourhoodPolicingTeam.mock
        await apiClient.add(response: .success(expectedResult))

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.neighbourhoodPolicingTeam(at: coordinate)
        } catch {
            resultError = error
        }

        #expect(resultError == .locationOutsideOfDataSetRegion)
        let requestedURLsCount = await apiClient.requestedURLs.count
        #expect(requestedURLsCount == 0)
    }

}
