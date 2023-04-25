@testable import PoliceAPI
import XCTest

final class UKOutcomeRepositoryTests: XCTestCase {

    var service: UKOutcomeRepository!
    var apiClient: MockAPIClient!
    var cache: MockCache!
    var availableDataRegion: CoordinateRegionDataModel!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        availableDataRegion = .test
        service = UKOutcomeRepository(apiClient: apiClient, cache: cache, availableDataRegion: availableDataRegion)
    }

    override func tearDown() {
        service = nil
        availableDataRegion = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testStreetLevelOutcomesForStreetWhenNotCachedReturnsOutcomes() async throws {
        let expectedResult = OutcomeDataModel.mocks
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelOutcomes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date).path
        )
    }

    func testStreetLevelOutcomesForStreetWhenNoDateReturnsOutcomes() async throws {
        let expectedResult = OutcomeDataModel.mocks
        let streetID = expectedResult[0].crime.location.street.id
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelOutcomes(forStreet: streetID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: Date()).path
        )
    }

    func testStreetLevelOutcomesForStreetWhenCachedReturnsCachedOutcomes() async throws {
        let expectedResult = OutcomeDataModel.mocks
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.streetLevelOutcomes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testStreetLevelOutcomesForStreetWhenNotCachedAndReturnsOutcomesShouldCacheResult() async throws {
        let expectedResult = OutcomeDataModel.mocks
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)
        apiClient.response = .success(expectedResult)
        _ = try await service.streetLevelOutcomes(forStreet: streetID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [OutcomeDataModel].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testStreetLevelOutcomesAtCoordinateReturnsOutcomes() async throws {
        let coordinate = CoordinateDataModel.mock
        let expectedResult = OutcomeDataModel.mocks
        let date = Date()
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelOutcomes(atCoordinate: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date).path
        )
    }

    func testStreetLevelOutcomesAtCoordinateWhenNoDateReturnsOutcomes() async throws {
        let coordinate = CoordinateDataModel.mock
        let expectedResult = OutcomeDataModel.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelOutcomes(atCoordinate: coordinate)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: Date()).path
        )
    }

    func testStreetLevelOutcomesAtCoordinateWhenCoordinateOutsideOfAvailableDataRegionReturnsNil() async throws {
        let coordinate = CoordinateDataModel.outsideAvailableDataRegion
        let expectedResult = OutcomeDataModel.mocks
        let date = Date()
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelOutcomes(atCoordinate: coordinate, date: date)

        XCTAssertNil(result)
        XCTAssertNil(apiClient.lastPath)
    }

    func testStreetLevelOutcomesInAreaReturnsOutcomes() async throws {
        let boundary = BoundaryDataModel.mock
        let expectedResult = OutcomeDataModel.mocks
        let date = Date()
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelOutcomes(inArea: boundary, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            OutcomesEndpoint.streetLevelOutcomesInArea(boundary: boundary, date: date).path
        )
    }

    func testStreetLevelOutcomesInAreaWhenNoDateReturnsOutcomes() async throws {
        let boundary = BoundaryDataModel.mock
        let expectedResult = OutcomeDataModel.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelOutcomes(inArea: boundary)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            OutcomesEndpoint.streetLevelOutcomesInArea(boundary: boundary, date: Date()).path
        )
    }

    func testFetchCaseHistoryNotCachedReturnsCaseHistory() async throws {
        let expectedResult = CaseHistoryDataModel.mock
        let crimeID = expectedResult.crime.crimeID
        apiClient.response = .success(expectedResult)

        let result = try await service.caseHistory(forCrime: crimeID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, OutcomesEndpoint.caseHistory(crimeID: crimeID).path)
    }

    func testFetchCaseHistoryWhenNotFoundReturnsNil() async throws {
        let crimeID = "123ABC"
        apiClient.response = .failure(PoliceDataError.notFound)

        let result = try await service.caseHistory(forCrime: crimeID)

        XCTAssertNil(result)
    }

    func testFetchCaseHistoryWhenCachedReturnsCachedCaseHistory() async throws {
        let expectedResult = CaseHistoryDataModel.mock
        let crimeID = expectedResult.crime.crimeID
        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.caseHistory(forCrime: crimeID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testFetchCaseHistoryWhenNotCachedAndReturnsCaseHistoryShouldCacheResult() async throws {
        let expectedResult = CaseHistoryDataModel.mock
        let crimeID = expectedResult.crime.crimeID
        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)
        apiClient.response = .success(expectedResult)
        _ = try await service.caseHistory(forCrime: crimeID)

        let cachedResult = await cache.object(for: cacheKey, type: CaseHistoryDataModel.self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}