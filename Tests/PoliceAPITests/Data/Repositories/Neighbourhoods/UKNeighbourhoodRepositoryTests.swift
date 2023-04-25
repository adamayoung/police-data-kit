@testable import PoliceAPI
import XCTest

final class UKNeighbourhoodRepositoryTests: XCTestCase {

    var service: UKNeighbourhoodRepository!
    var apiClient: MockAPIClient!
    var cache: MockCache!
    var availableDataRegion: CoordinateRegionDataModel!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        availableDataRegion = .test
        service = UKNeighbourhoodRepository(apiClient: apiClient, cache: cache, availableDataRegion: availableDataRegion)
    }

    override func tearDown() {
        service = nil
        availableDataRegion = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testNeighboursWhenNotCachedReturnsNeighbourhoodReferences() async throws {
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodReferenceDataModel.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.neighbourhoods(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.list(policeForceID: policeForceID).path)
    }

    func testNeighboursWhenCachedReturnsCachedNeighbourhoodReferences() async throws {
        let policeForceID = "leicestershire"
        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)
        let expectedResult = NeighbourhoodReferenceDataModel.mocks
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.neighbourhoods(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testNeighboursWhenNotCachedAndReturnsNeighbourhoodReferencesShouldCacheResult() async throws {
        let policeForceID = "leicestershire"
        let cacheKey = NeighbourhoodsInPoliceForceCachingKey(policeForceID: policeForceID)
        let expectedResult = NeighbourhoodReferenceDataModel.mocks
        apiClient.response = .success(expectedResult)
        _ = try await service.neighbourhoods(inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: [NeighbourhoodReferenceDataModel].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testNeighbourhoodWhenNotCachedReturnsNeighbourhood() async throws {
        let expectedResult = NeighbourhoodDataModel.mock
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
        let expectedResult = NeighbourhoodDataModel.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        let cacheKey = NeighbourhoodCachingKey(id: id, policeForceID: policeForceID)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testNeighbourhoodWhenNotCachedAndReturnsNeighbourhoodShouldCacheResult() async throws {
        let expectedResult = NeighbourhoodDataModel.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        let cacheKey = NeighbourhoodCachingKey(id: id, policeForceID: policeForceID)
        apiClient.response = .success(expectedResult)
        _ = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: NeighbourhoodDataModel.self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testBoundaryWhenNotCachedReturnsBoundary() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = BoundaryDataModel.mock
        apiClient.response = .success(expectedResult)

        let result = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID).path
        )
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
        let expectedResult = BoundaryDataModel.mock
        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testBoundaryWhenNotCachedAndReturnsBoundaryShouldCacheResult() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = BoundaryDataModel.mock
        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        apiClient.response = .success(expectedResult)
        _ = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: BoundaryDataModel.self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testPoliceOfficersWhenNotCachedReturnsPoliceOfficers() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficerDataModel.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            NeighbourhoodsEndpoint.policeOfficers(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID).path
        )
    }

    func testPoliceOfficersWhenCachedReturnsCachedPoliceOfficers() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficerDataModel.mocks
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
        let expectedResult = PoliceOfficerDataModel.mocks
        let cacheKey = NeighbourhoodPoliceOfficersCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )
        apiClient.response = .success(expectedResult)
        _ = try await service.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: [PoliceOfficerDataModel].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testPrioritiesWhenNotCachedReturnsNeighbourhoodPriorities() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriorityDataModel.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            NeighbourhoodsEndpoint.priorities(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID).path
        )
    }

    func testPrioritiesWhenCachedReturnsCachedNeighbourhoodPriorities() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriorityDataModel.mocks
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
        let expectedResult = NeighbourhoodPriorityDataModel.mocks
        let cacheKey = NeighbourhoodPrioritiesCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )
        apiClient.response = .success(expectedResult)
        _ = try await service.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: [NeighbourhoodPriorityDataModel].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testNeighbourhoodPolicingTeamAtCoordinateReturnsNeighbourhoodPolicingTeam() async throws {
        let coordinate = CoordinateDataModel.mock
        let expectedResult = NeighbourhoodPolicingTeamDataModel.mock
        apiClient.response = .success(expectedResult)

        let result = try await service.neighbourhoodPolicingTeam(atCoordinate: coordinate)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).path)
    }

    func testNeighbourhoodPolicingTeamAtCoordinateWhenNotFoundReturnsNil() async throws {
        let coordinate = CoordinateDataModel.mock
        apiClient.response = .failure(PoliceDataError.notFound)

        let result = try await service.neighbourhoodPolicingTeam(atCoordinate: coordinate)

        XCTAssertNil(result)
    }

    func testNeighbourhoodPolicingTeamAtCoordinateWhenCoordinateOutsideOfAvailableDataRegionReturnsNil() async throws {
        let coordinate = CoordinateDataModel.outsideAvailableDataRegion
        let expectedResult = NeighbourhoodPolicingTeamDataModel.mock
        apiClient.response = .success(expectedResult)

        let result = try await service.neighbourhoodPolicingTeam(atCoordinate: coordinate)

        XCTAssertNil(result)
        XCTAssertNil(apiClient.lastPath)
    }

}
