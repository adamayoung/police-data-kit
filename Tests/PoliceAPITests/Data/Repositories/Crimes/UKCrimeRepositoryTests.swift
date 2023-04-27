import MapKit
@testable import PoliceAPI
import XCTest

final class UKCrimeRepositoryTests: XCTestCase {

    var repository: UKCrimeRepository!
    var apiClient: MockAPIClient!
    var cache: MockCache!
    var availableDataRegion: MKCoordinateRegion!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        availableDataRegion = .test
        repository = UKCrimeRepository(apiClient: apiClient, cache: cache, availableDataRegion: availableDataRegion)
    }

    override func tearDown() {
        repository = nil
        availableDataRegion = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testStreetLevelCrimesAtCoordinateReturnsCrimes() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let date = Date()
        let expectedResult = CrimeDataModel.mocks.map(Crime.init)
        apiClient.response = .success(CrimeDataModel.mocks)

        let result = try await repository.streetLevelCrimes(at: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date).path
        )
    }

    func testStreetLevelCrimesAtCoordsWhenOutsideDataRegionThrowsLocationOutsideOfDataSetRegionError() async throws {
        let coordinate = CLLocationCoordinate2D(dataModel: .outsideAvailableDataRegion)
        let date = Date()
        apiClient.response = .success(CrimeDataModel.mocks)

        var resultError: CrimeError?
        do {
            _ = try await repository.streetLevelCrimes(at: coordinate, date: date)
        } catch let error as CrimeError {
            resultError = error
        }

        XCTAssertEqual(resultError, .locationOutsideOfDataSetRegion)
        XCTAssertNil(apiClient.lastPath)
    }

    func testStreetLevelCrimesInAreaReturnsCrimes() async throws {
        let boundary = [CLLocationCoordinate2D](dataModel: .mock)
        let date = Date()
        let expectedResult = CrimeDataModel.mocks.map(Crime.init)
        apiClient.response = .success(CrimeDataModel.mocks)

        let result = try await repository.streetLevelCrimes(in: boundary, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.streetLevelCrimesInArea(boundary: .mock, date: date).path
        )
    }

    func testCrimesForStreetWhenNotCachedReturnsCrimes() async throws {
        let expectedResult = CrimeDataModel.mocks.map(Crime.init)
        let streetID = expectedResult[0].location.street.id
        let date = Date()
        apiClient.response = .success(CrimeDataModel.mocks)

        let result = try await repository.crimes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date).path
        )
    }

    func testCrimesForStreetWhenCachedReturnsCachedCrimes() async throws {
        let expectedResult = CrimeDataModel.mocks.map(Crime.init)
        let streetID = expectedResult[0].location.street.id
        let date = Date()
        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await repository.crimes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testCrimesForStreetWhenNotCachedAndReturnsCrimesShouldCacheResult() async throws {
        let expectedResult = CrimeDataModel.mocks.map(Crime.init)
        let streetID = expectedResult[0].location.street.id
        let date = Date()
        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)
        apiClient.response = .success(CrimeDataModel.mocks)
        _ = try await repository.crimes(forStreet: streetID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [Crime].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testCrimesAtCoordinateReturnsCrimes() async throws {
        let coordinate = CLLocationCoordinate2D.mock
        let date = Date()
        let expectedResult = CrimeDataModel.mocks.map(Crime.init)
        apiClient.response = .success(CrimeDataModel.mocks)

        let result = try await repository.crimes(at: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date).path
        )
    }

    func testCrimesAtCoordsWhenNotInAvailableDataRegionThrowsLocationOutsideOfDataSetRegionError() async throws {
        let coordinate = CLLocationCoordinate2D(dataModel: .outsideAvailableDataRegion)
        let date = Date()
        apiClient.response = .success(CrimeDataModel.mocks)

        var resultError: CrimeError?
        do {
            _ = try await repository.crimes(at: coordinate, date: date)
        } catch let error as CrimeError {
            resultError = error
        }

        XCTAssertEqual(resultError, .locationOutsideOfDataSetRegion)
        XCTAssertNil(apiClient.lastPath)
    }

    func testCrimesWithNoLocationWhenNotCachedReturnsCrimes() async throws {
        let categoryID = CrimeCategoryDataModel.mock.id
        let policeForceID = PoliceForceDataModel.mock.id
        let date = Date()
        let expectedResult = CrimeDataModel.mocks.map(Crime.init)
        apiClient.response = .success(CrimeDataModel.mocks)

        let result = try await repository.crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID,
                                                               date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID, date: date).path
        )
    }

    func testCrimesWithNoLocationWhenCachedReturnsCachedCrimes() async throws {
        let categoryID = CrimeCategoryDataModel.mock.id
        let policeForceID = PoliceForceDataModel.mock.id
        let date = Date()
        let expectedResult = CrimeDataModel.mocks.map(Crime.init)
        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(categoryID: categoryID,
                                                                              policeForceID: policeForceID, date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await repository.crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID,
                                                            date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testCrimesWithNoLocationWhenNotCachedAndReturnsCrimesShouldCacheResult() async throws {
        let categoryID = CrimeCategoryDataModel.mock.id
        let policeForceID = PoliceForceDataModel.mock.id
        let date = Date()
        let expectedResult = CrimeDataModel.mocks.map(Crime.init)
        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(categoryID: categoryID,
                                                                              policeForceID: policeForceID, date: date)
        apiClient.response = .success(CrimeDataModel.mocks)
        _ = try await repository.crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [Crime].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testCrimeCategoriesWhenNotCachedReturnsCrimeCategories() async throws {
        let expectedResult = CrimeCategoryDataModel.mocks.map(CrimeCategory.init)
        let date = Date()
        apiClient.response = .success(CrimeCategoryDataModel.mocks)

        let result = try await repository.crimeCategories(forDate: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, CrimesEndpoint.categories(date: date).path)
    }

    func testCrimeCategoriesWhenCachedReturnsCachedCrimeCategories() async throws {
        let expectedResult = CrimeCategoryDataModel.mocks.map(CrimeCategory.init)
        let date = Date()
        let cacheKey = CrimeCategoriesCachingKey(date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await repository.crimeCategories(forDate: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testCrimeCategoriesWhenNotCachedReturnsCrimeCategoriesShouldCacheResult() async throws {
        let expectedResult = CrimeCategoryDataModel.mocks.map(CrimeCategory.init)
        let date = Date()
        let cacheKey = CrimeCategoriesCachingKey(date: date)
        apiClient.response = .success(CrimeCategoryDataModel.mocks)
        _ = try await repository.crimeCategories(forDate: date)

        let cachedResult = await cache.object(for: cacheKey, type: [CrimeCategory].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
