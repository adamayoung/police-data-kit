import MapKit
@testable import PoliceDataKit
import XCTest

final class NeighbourhoodServiceTests: XCTestCase {

    var service: NeighbourhoodService!
    var apiClient: MockAPIClient!
    var cache: MockCache!
    var availableDataRegion: MKCoordinateRegion!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
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

    func testNeighboursWhenNotCachedReturnsNeighbourhoodReferences() async throws {
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodReference.mocks
        apiClient.response = .success(NeighbourhoodReference.mocks)

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
        apiClient.response = .success(NeighbourhoodReference.mocks)
        _ = try await service.neighbourhoods(inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: [NeighbourhoodReference].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testNeighbourhoodWhenNotCachedReturnsNeighbourhood() async throws {
        let expectedResult = Neighbourhood.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        apiClient.response = .success(Neighbourhood.mock)

        let result = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID).path)
    }

    func testNeighbourhoodWhenNotCachedAndNotFoundThrowsNotFoundError() async throws {
        let id = "NC04"
        let policeForceID = "leicestershire"
        apiClient.response = .failure(APIClientError.notFound)

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)
        } catch let error as NeighbourhoodError {
            resultError = error
        }

        XCTAssertEqual(resultError, .notFound)
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
        apiClient.response = .success(Neighbourhood.mock)
        _ = try await service.neighbourhood(withID: id, inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: Neighbourhood.self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testBoundaryWhenNotCachedReturnsBoundary() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = CLLocationCoordinate2D.mocks
        apiClient.response = .success(CLLocationCoordinate2D.mocks)

        let result = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID).path
        )
    }

    func testBoundaryWhenNotCachedAndNotFoundThrowsNotFoundError() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        apiClient.response = .failure(APIClientError.notFound)

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)
        } catch let error as NeighbourhoodError {
            resultError = error
        }

        XCTAssertEqual(resultError, .notFound)
    }

    func testBoundaryWhenCachedReturnsCachedBoundary() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = CLLocationCoordinate2D.mocks
        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testBoundaryWhenNotCachedAndReturnsBoundaryShouldCacheResult() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = CLLocationCoordinate2D.mocks
        let cacheKey = NeighbourhoodBoundaryCachingKey(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
        apiClient.response = .success(CLLocationCoordinate2D.mocks)
        _ = try await service.boundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: [CLLocationCoordinate2D].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testPoliceOfficersWhenNotCachedReturnsPoliceOfficers() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficer.mocks
        apiClient.response = .success(PoliceOfficer.mocks)

        let result = try await service.policeOfficers(forNeighbourhood: neighbourhoodID,
                                                         inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            NeighbourhoodsEndpoint.policeOfficers(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID).path
        )
    }

    func testPoliceOfficersWhenCachedReturnsCachedPoliceOfficers() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficer.mocks
        let cacheKey = NeighbourhoodPoliceOfficersCachingKey(
            neighbourhoodID: neighbourhoodID, policeForceID: policeForceID
        )
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.policeOfficers(forNeighbourhood: neighbourhoodID,
                                                         inPoliceForce: policeForceID)

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
        apiClient.response = .success(PoliceOfficer.mocks)
        _ = try await service.policeOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: [PoliceOfficer].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testPrioritiesWhenNotCachedReturnsNeighbourhoodPriorities() async throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriority.mocks
        apiClient.response = .success(NeighbourhoodPriority.mocks)

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
        apiClient.response = .success(NeighbourhoodPriority.mocks)
        _ = try await service.priorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: [NeighbourhoodPriority].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testNeighbourhoodPolicingTeamAtCoordinateReturnsNeighbourhoodPolicingTeam() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let expectedResult = NeighbourhoodPolicingTeam.mock
        apiClient.response = .success(NeighbourhoodPolicingTeam.mock)

        let result = try await service.neighbourhoodPolicingTeam(at: coordinate)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).path)
    }

    func testNeighbourhoodPolicingTeamAtCoordinateWhenNotFoundThrowsNotFoundError() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        apiClient.response = .failure(APIClientError.notFound)

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.neighbourhoodPolicingTeam(at: coordinate)
        } catch let error as NeighbourhoodError {
            resultError = error
        }

        XCTAssertEqual(resultError, .notFound)
    }

    func testNeighbourhoodPolicingTeamAtCoordsWhenNotInAvailableDataRegionThrowsError() async throws {
        let coordinate = CLLocationCoordinate2D.outsideAvailableDataRegion
        let expectedResult = NeighbourhoodPolicingTeam.mock
        apiClient.response = .success(expectedResult)

        var resultError: NeighbourhoodError?
        do {
            _ = try await service.neighbourhoodPolicingTeam(at: coordinate)
        } catch let error as NeighbourhoodError {
            resultError = error
        }

        XCTAssertEqual(resultError, .locationOutsideOfDataSetRegion)
        XCTAssertNil(apiClient.lastPath)
    }

}
