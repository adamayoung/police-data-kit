@testable import PoliceAPI
import XCTest

final class UKPoliceForceServiceTests: XCTestCase {

    var service: UKPoliceForceService!
    var apiClient: MockAPIClient!
    var cache: MockCache!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        service = UKPoliceForceService(apiClient: apiClient, cache: cache)
    }

    override func tearDown() {
        service = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testPoliceForcesWhenNotCachedReturnsPoliceForceReferences() async throws {
        let expectedResult = PoliceForceReference.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.policeForces()

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.list.path)
    }

    func testPoliceForcesWhenCachedReturnsCachedPoliceForceReferences() async throws {
        let expectedResult = PoliceForceReference.mocks
        let cacheKey = PoliceForcesCachingKey()
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.policeForces()

        XCTAssertEqual(result, expectedResult)

        XCTAssertNil(apiClient.lastPath)
    }

    func testPoliceForcesWhenNotCachedAndReturnsPoliceForceReferencesShouldCacheResult() async throws {
        let expectedResult = PoliceForceReference.mocks
        let cacheKey = PoliceForcesCachingKey()
        apiClient.response = .success(expectedResult)
        _ = try await service.policeForces()

        let cachedResult = await cache.object(for: cacheKey, type: [PoliceForceReference].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testPoliceForceWhenNotCachedReturnsPoliceForce() async throws {
        let expectedResult = PoliceForce.mock
        let id = expectedResult.id
        apiClient.response = .success(expectedResult)

        let result = try await service.policeForce(withID: id)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.details(id: id).path)
    }

    func testPoliceForceWhenNotCachedAndNotFoundReturnsNil() async throws {
        let id = "leicestershire"
        apiClient.response = .failure(PoliceDataError.notFound)

        let result = try await service.policeForce(withID: id)

        XCTAssertNil(result)
    }

    func testPoliceForceWhenCachedReturnsCachedPoliceForce() async throws {
        let expectedResult = PoliceForce.mock
        let id = expectedResult.id
        let cacheKey = PoliceForceCachingKey(id: id)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.policeForce(withID: id)

        XCTAssertEqual(result, expectedResult)

        XCTAssertNil(apiClient.lastPath)
    }

    func testPoliceForceWhenNotCachedAndReturnsCachedPoliceForceShouldCacheResult() async throws {
        let expectedResult = PoliceForce.mock
        let id = expectedResult.id
        let cacheKey = PoliceForceCachingKey(id: id)
        apiClient.response = .success(expectedResult)
        _ = try await service.policeForce(withID: id)

        let cachedResult = await cache.object(for: cacheKey, type: PoliceForce.self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testFetchSeniorOfficersWhenNotCachedReturnsPoliceOfficers() async throws {
        let expectedResult = PoliceOfficer.mocks
        let policeForceID = "leicestershire"
        apiClient.response = .success(expectedResult)

        let result = try await service.seniorOfficers(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID).path)
    }

    func testFetchSeniorOfficersWhenNotCachedAndPoliceForceNotFoundReturnsNil() async throws {
        let policeForceID = "leicestershire"
        apiClient.response = .failure(PoliceDataError.notFound)

        let result = try await service.seniorOfficers(inPoliceForce: policeForceID)

        XCTAssertNil(result)
    }

    func testFetchSeniorOfficersWhenCachedReturnsCachedPoliceOfficers() async throws {
        let expectedResult = PoliceOfficer.mocks
        let policeForceID = "leicestershire"
        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.seniorOfficers(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)

        XCTAssertNil(apiClient.lastPath)
    }

    func testFetchSeniorOfficersWhenNotCachedAndReturnsPoliceOfficersShouldCacheResult() async throws {
        let expectedResult = PoliceOfficer.mocks
        let policeForceID = "leicestershire"
        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)
        apiClient.response = .success(expectedResult)
        _ = try await service.seniorOfficers(inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: [PoliceOfficer].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
