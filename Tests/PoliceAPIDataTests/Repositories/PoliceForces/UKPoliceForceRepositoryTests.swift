@testable import PoliceAPIData
import PoliceAPIDomain
import XCTest

final class UKPoliceForceRepositoryTests: XCTestCase {

    var repository: UKPoliceForceRepository!
    var apiClient: MockAPIClient!
    var cache: MockCache!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        repository = UKPoliceForceRepository(apiClient: apiClient, cache: cache)
    }

    override func tearDown() {
        repository = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testPoliceForcesWhenNotCachedReturnsPoliceForceReferences() async throws {
        let expectedResult = PoliceForceReferenceDataModel.mocks.map(PoliceForceReference.init)
        apiClient.response = .success(PoliceForceReferenceDataModel.mocks)

        let result = try await repository.policeForces()

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.list.path)
    }

    func testPoliceForcesWhenCachedReturnsCachedPoliceForceReferences() async throws {
        let expectedResult = PoliceForceReferenceDataModel.mocks.map(PoliceForceReference.init)
        let cacheKey = PoliceForcesCachingKey()
        await cache.set(expectedResult, for: cacheKey)

        let result = try await repository.policeForces()

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testPoliceForcesWhenNotCachedAndReturnsPoliceForceReferencesShouldCacheResult() async throws {
        let expectedResult = PoliceForceReferenceDataModel.mocks.map(PoliceForceReference.init)
        let cacheKey = PoliceForcesCachingKey()
        apiClient.response = .success(PoliceForceReferenceDataModel.mocks)
        _ = try await repository.policeForces()

        let cachedResult = await cache.object(for: cacheKey, type: [PoliceForceReference].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testPoliceForceWhenNotCachedReturnsPoliceForce() async throws {
        let expectedResult = PoliceForce(dataModel: .mock)
        let id = expectedResult.id
        apiClient.response = .success(PoliceForceDataModel.mock)

        let result = try await repository.policeForce(withID: id)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.details(id: id).path)
    }

    func testPoliceForceWhenNotCachedAndNotFoundReturnsNil() async throws {
        let id = "leicestershire"
        apiClient.response = .failure(PoliceDataError.notFound)

        let result = try await repository.policeForce(withID: id)

        XCTAssertNil(result)
    }

    func testPoliceForceWhenCachedReturnsCachedPoliceForce() async throws {
        let expectedResult = PoliceForce(dataModel: .mock)
        let id = expectedResult.id
        let cacheKey = PoliceForceCachingKey(id: id)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await repository.policeForce(withID: id)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testPoliceForceWhenNotCachedAndReturnsPoliceForceShouldCacheResult() async throws {
        let expectedResult = PoliceForce(dataModel: .mock)
        let id = expectedResult.id
        let cacheKey = PoliceForceCachingKey(id: id)
        apiClient.response = .success(PoliceForceDataModel.mock)
        _ = try await repository.policeForce(withID: id)

        let cachedResult = await cache.object(for: cacheKey, type: PoliceForce.self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testFetchSeniorOfficersWhenNotCachedReturnsPoliceOfficers() async throws {
        let expectedResult = PoliceOfficerDataModel.mocks.map(PoliceOfficer.init)
        let policeForceID = "leicestershire"
        apiClient.response = .success(PoliceOfficerDataModel.mocks)

        let result = try await repository.seniorOfficers(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID).path)
    }

    func testFetchSeniorOfficersWhenNotCachedAndPoliceForceNotFoundReturnsNil() async throws {
        let policeForceID = "leicestershire"
        apiClient.response = .failure(PoliceDataError.notFound)

        let result = try await repository.seniorOfficers(inPoliceForce: policeForceID)

        XCTAssertNil(result)
    }

    func testFetchSeniorOfficersWhenCachedReturnsCachedPoliceOfficers() async throws {
        let expectedResult = PoliceOfficerDataModel.mocks.map(PoliceOfficer.init)
        let policeForceID = "leicestershire"
        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await repository.seniorOfficers(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testFetchSeniorOfficersWhenNotCachedAndReturnsPoliceOfficersShouldCacheResult() async throws {
        let expectedResult = PoliceOfficerDataModel.mocks.map(PoliceOfficer.init)
        let policeForceID = "leicestershire"
        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)
        apiClient.response = .success(PoliceOfficerDataModel.mocks)
        _ = try await repository.seniorOfficers(inPoliceForce: policeForceID)

        let cachedResult = await cache.object(for: cacheKey, type: [PoliceOfficer].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
