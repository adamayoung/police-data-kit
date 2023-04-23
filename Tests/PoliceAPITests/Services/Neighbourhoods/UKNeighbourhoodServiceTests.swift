@testable import PoliceAPI
import XCTest

final class UKNeighbourhoodServiceTests: XCTestCase {

    var service: UKNeighbourhoodService!
    var apiClient: MockAPIClient!
    var cache: MockCache!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        service = UKNeighbourhoodService(apiClient: apiClient, cache: cache)
    }

    override func tearDown() {
        service = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testNeighboursWhenNotCachedReturnsNeighbourhoodReferences() async throws {
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodReference.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.neighbourhoods(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.list(policeForceID: policeForceID).path)
    }

    func testNeighboursWhenCachedReturnsCachedNeighbourhoodReferences() async throws {
        let policeForceID = "leicestershire"
        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)
        let expectedResult = NeighbourhoodReference.mocks
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.neighbourhoods(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertNil(apiClient.lastPath)
    }

    func testNeighboursWhenNotCachedAndReturnsNeighbourhoodReferencesShouldCacheResult() async throws {
        let policeForceID = "leicestershire"
        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)
        let expectedResult = NeighbourhoodReference.mocks
        apiClient.response = .success(expectedResult)
        _ = try await service.neighbourhoods(inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: [NeighbourhoodReference].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testNeighbourhoodWhenNotCachedReturnsNeighbourhood() async throws {
        let expectedResult = Neighbourhood.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        apiClient.response = .success(expectedResult)

        let result = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID).path)
    }

    func testNeighbourhoodWhenNotCachedAndNotFoundReturnsNil() async throws {
        let id = "NC04"
        let policeForceID = "leicestershire"
        apiClient.response = .failure(PoliceDataError.notFound)

        let result = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        XCTAssertNil(result)
    }

    func testNeighbourhoodWhenCachedReturnsCachedNeighbourhood() async throws {
        let expectedResult = Neighbourhood.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        let cacheKey = NeighbourhoodCachingKey(id: id, policeForceID: policeForceID)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertNil(apiClient.lastPath)
    }

    func testNeighbourhoodWhenNotCachedAndReturnsNeighbourhoodShouldCacheResult() async throws {
        let expectedResult = Neighbourhood.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        let cacheKey = NeighbourhoodCachingKey(id: id, policeForceID: policeForceID)
        apiClient.response = .success(expectedResult)
        _ = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: Neighbourhood.self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testBoundaryWhenNotCachedReturnsBoundary() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = Boundary.mock
        apiClient.response = .success(expectedResult)

        let result = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID,
                                                                           policeForceID: policeForceID).path)
    }

    func testBoundaryWhenNotCachedAndNotFoundReturnsNil() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        apiClient.response = .failure(PoliceDataError.notFound)

        let result = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertNil(result)
    }

    func testBoundaryWhenCachedReturnsCachedBoundary() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = Boundary.mock
        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertNil(apiClient.lastPath)
    }

    func testBoundaryWhenNotCachedAndReturnsBoundaryShouldCacheResult() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = Boundary.mock
        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        apiClient.response = .success(expectedResult)
        _ = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: Boundary.self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testPoliceOfficersWhenNotCachedReturnsPoliceOfficers() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficer.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.policeOfficers(neighbourhoodID: neighbourhoodID,
                                                                                 policeForceID: policeForceID).path)
    }

    func testPoliceOfficersWhenCachedReturnsCachedPoliceOfficers() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficer.mocks
        let cacheKey = NeighbourhoodPoliceOfficersCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertNil(apiClient.lastPath)
    }

    func testPoliceOfficersWhenNotCachedAndReturnsPoliceOfficersShouldCacheResult() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficer.mocks
        let cacheKey = NeighbourhoodPoliceOfficersCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )
        apiClient.response = .success(expectedResult)
        _ = try await service.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: [PoliceOfficer].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testPrioritiesWhenNotCachedReturnsNeighbourhoodPriorities() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriority.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.priorities(neighbourhoodID: neighbourhoodID,
                                                                             policeForceID: policeForceID).path)
    }

    func testPrioritiesWhenCachedReturnsCachedNeighbourhoodPriorities() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriority.mocks
        let cacheKey = NeighbourhoodPrioritiesCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertNil(apiClient.lastPath)
    }

    func testPrioritiesWhenNotCachedAndReturnsNeighbourhoodPrioritiesShouldCacheResult() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriority.mocks
        let cacheKey = NeighbourhoodPrioritiesCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )
        apiClient.response = .success(expectedResult)
        _ = try await service.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: [NeighbourhoodPriority].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testNeighbourhoodPolicingTeamAtCoordinateReturnsNeighbourhoodPolicingTeam() async throws {
        let coordinate = Coordinate.mock
        let expectedResult = NeighbourhoodPolicingTeam.mock
        apiClient.response = .success(expectedResult)

        let result = try await service.neighbourhoodPolicingTeam(atCoordinate: coordinate)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).path)
    }

    func testNeighbourhoodPolicingTeamAtCoordinateWhenNotFoundReturnsNil() async throws {
        let coordinate = Coordinate.mock
        apiClient.response = .failure(PoliceDataError.notFound)

        let result = try await service.neighbourhoodPolicingTeam(atCoordinate: coordinate)

        XCTAssertNil(result)
    }

}
