import CoreLocation
@testable import PoliceAPI
import XCTest

final class UKOutcomeRepositoryTests: XCTestCase {

    var repository: UKOutcomeRepository!
    var apiClient: MockAPIClient!
    var cache: MockCache!
    var availableDataRegion: CoordinateRegionDataModel!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        availableDataRegion = .test
        repository = UKOutcomeRepository(apiClient: apiClient, cache: cache, availableDataRegion: availableDataRegion)
    }

    override func tearDown() {
        repository = nil
        availableDataRegion = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testStreetLevelOutcomesForStreetWhenNotCachedReturnsOutcomes() async throws {
        let expectedResult = OutcomeDataModel.mocks.map(Outcome.init)
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        apiClient.response = .success(OutcomeDataModel.mocks)

        let result = try await repository.streetLevelOutcomes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date).path
        )
    }

    func testStreetLevelOutcomesForStreetWhenCachedReturnsCachedOutcomes() async throws {
        let expectedResult = OutcomeDataModel.mocks.map(Outcome.init)
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await repository.streetLevelOutcomes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testStreetLevelOutcomesForStreetWhenNotCachedAndReturnsOutcomesShouldCacheResult() async throws {
        let expectedResult = OutcomeDataModel.mocks.map(Outcome.init)
        let streetID = expectedResult[0].crime.location.street.id
        let date = Date()
        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)
        apiClient.response = .success(OutcomeDataModel.mocks)
        _ = try await repository.streetLevelOutcomes(forStreet: streetID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [Outcome].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testStreetLevelOutcomesAtCoordinateReturnsOutcomes() async throws {
        let coordinate = CLLocationCoordinate2D(dataModel: .mock)
        let expectedResult = OutcomeDataModel.mocks.map(Outcome.init)
        let date = Date()
        apiClient.response = .success(OutcomeDataModel.mocks)

        let result = try await repository.streetLevelOutcomes(at: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: .mock, date: date).path
        )
    }

    func testStreetLevelOutcomesAtCoordinateWhenCoordinateOutsideOfAvailableDataRegionReturnsNil() async throws {
        let coordinate = CLLocationCoordinate2D(dataModel: .outsideAvailableDataRegion)
        let date = Date()
        apiClient.response = .success(OutcomeDataModel.mocks)

        let result = try await repository.streetLevelOutcomes(at: coordinate, date: date)

        XCTAssertNil(result)
        XCTAssertNil(apiClient.lastPath)
    }

    func testStreetLevelOutcomesInAreaReturnsOutcomes() async throws {
        let boundary = [CLLocationCoordinate2D](dataModel: .mock)
        let expectedResult = OutcomeDataModel.mocks.map(Outcome.init)
        let date = Date()
        apiClient.response = .success(OutcomeDataModel.mocks)

        let result = try await repository.streetLevelOutcomes(in: boundary, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            OutcomesEndpoint.streetLevelOutcomesInArea(boundary: .mock, date: date).path
        )
    }

    func testFetchCaseHistoryNotCachedReturnsCaseHistory() async throws {
        let expectedResult = CaseHistory(dataModel: .mock)
        let crimeID = expectedResult.crime.crimeID
        apiClient.response = .success(CaseHistoryDataModel.mock)

        let result = try await repository.caseHistory(forCrime: crimeID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, OutcomesEndpoint.caseHistory(crimeID: crimeID).path)
    }

    func testFetchCaseHistoryWhenNotFoundReturnsNil() async throws {
        let crimeID = "123ABC"
        apiClient.response = .failure(PoliceDataError.notFound)

        let result = try await repository.caseHistory(forCrime: crimeID)

        XCTAssertNil(result)
    }

    func testFetchCaseHistoryWhenCachedReturnsCachedCaseHistory() async throws {
        let expectedResult = CaseHistory(dataModel: .mock)
        let crimeID = expectedResult.crime.crimeID
        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await repository.caseHistory(forCrime: crimeID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testFetchCaseHistoryWhenNotCachedAndReturnsCaseHistoryShouldCacheResult() async throws {
        let expectedResult = CaseHistory(dataModel: .mock)
        let crimeID = expectedResult.crime.crimeID
        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)
        apiClient.response = .success(CaseHistoryDataModel.mock)
        _ = try await repository.caseHistory(forCrime: crimeID)

        let cachedResult = await cache.object(for: cacheKey, type: CaseHistory.self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
