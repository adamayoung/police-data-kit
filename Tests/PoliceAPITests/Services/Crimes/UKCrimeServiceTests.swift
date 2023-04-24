@testable import PoliceAPI
import XCTest

final class UKCrimeServiceTests: XCTestCase {

    var service: UKCrimeService!
    var apiClient: MockAPIClient!
    var cache: MockCache!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        cache = MockCache()
        service = UKCrimeService(apiClient: apiClient, cache: cache)
    }

    override func tearDown() {
        service = nil
        cache = nil
        apiClient = nil
        super.tearDown()
    }

    func testStreetLevelCrimesAtCoordinateReturnsCrimes() async throws {
        let coordinate = Coordinate.mock
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelCrimes(atCoordinate: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date).path
        )
    }

    func testStreetLevelCrimesAtCoordinateWhenNoDateReturnsCrimes() async throws {
        let coordinate = Coordinate.mock
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelCrimes(atCoordinate: coordinate)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: Date()).path
        )
    }

    func testStreetLevelCrimesInAreaReturnsCrimes() async throws {
        let boundary = Boundary.mock
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelCrimes(inArea: boundary, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.streetLevelCrimesInArea(boundary: boundary, date: date).path
        )
    }

    func testStreetLevelCrimesInAreaWhenNoDateReturnsCrimes() async throws {
        let boundary = Boundary.mock
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.streetLevelCrimes(inArea: boundary)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.streetLevelCrimesInArea(boundary: boundary, date: Date()).path
        )
    }

    func testCrimesForStreetWhenNotCachedReturnsCrimes() async throws {
        let expectedResult = Crime.mocks
        let streetID = expectedResult[0].location.street.id
        let date = Date()
        apiClient.response = .success(expectedResult)

        let result = try await service.crimes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date).path
        )
    }

    func testCrimesForStreetWhenNoDateReturnsCrimes() async throws {
        let expectedResult = Crime.mocks
        let streetID = expectedResult[0].location.street.id
        apiClient.response = .success(expectedResult)

        let result = try await service.crimes(forStreet: streetID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: Date()).path
        )
    }

    func testCrimesForStreetWhenCachedReturnsCachedCrimes() async throws {
        let expectedResult = Crime.mocks
        let streetID = expectedResult[0].location.street.id
        let date = Date()
        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.crimes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testCrimesForStreetWhenNotCachedAndReturnsCrimesShouldCacheResult() async throws {
        let expectedResult = Crime.mocks
        let streetID = expectedResult[0].location.street.id
        let date = Date()
        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)
        apiClient.response = .success(expectedResult)
        _ = try await service.crimes(forStreet: streetID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [Crime].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testCrimesAtCoordinateReturnsCrimes() async throws {
        let coordinate = Coordinate.mock
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.crimes(atCoordinate: coordinate, date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date).path
        )
    }

    func testCrimesAtCoordinateWhenNoDateReturnsCrimes() async throws {
        let coordinate = Coordinate.mock
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.crimes(atCoordinate: coordinate)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: Date()).path
        )
    }

    func testCrimesWithNoLocationWhenNotCachedReturnsCrimes() async throws {
        let categoryID = CrimeCategory.mock.id
        let policeForceID = PoliceForce.mock.id
        let date = Date()
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID,
                                                            date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesWithNoLocation(categoryID: categoryID, policeForceID: policeForceID, date: date).path
        )
    }

    func testCrimesWithNoLocationWhenNoCategoryOrDateReturnsCrimes() async throws {
        let policeForceID = PoliceForce.mock.id
        let expectedResult = Crime.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.crimesWithNoLocation(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(
            apiClient.lastPath,
            CrimesEndpoint.crimesWithNoLocation(categoryID: CrimeCategory.defaultID, policeForceID: policeForceID,
                                                date: Date()).path
        )
    }

    func testCrimesWithNoLocationWhenCachedReturnsCachedCrimes() async throws {
        let categoryID = CrimeCategory.mock.id
        let policeForceID = PoliceForce.mock.id
        let date = Date()
        let expectedResult = Crime.mocks
        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(categoryID: categoryID,
                                                                              policeForceID: policeForceID, date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID,
                                                            date: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testCrimesWithNoLocationWhenNotCachedAndReturnsCrimesShouldCacheResult() async throws {
        let categoryID = CrimeCategory.mock.id
        let policeForceID = PoliceForce.mock.id
        let date = Date()
        let expectedResult = Crime.mocks
        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(categoryID: categoryID,
                                                                              policeForceID: policeForceID, date: date)
        apiClient.response = .success(expectedResult)
        _ = try await service.crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID, date: date)

        let cachedResult = await cache.object(for: cacheKey, type: [Crime].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

    func testCrimeCategoriesWhenNotCachedReturnsCrimeCategories() async throws {
        let expectedResult = CrimeCategory.mocks
        let date = Date()
        apiClient.response = .success(expectedResult)

        let result = try await service.crimeCategories(forDate: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, CrimesEndpoint.categories(date: date).path)
    }

    func testCrimeCategoriesWhenNoDateReturnsCrimeCategories() async throws {
        let expectedResult = CrimeCategory.mocks
        apiClient.response = .success(expectedResult)

        let result = try await service.crimeCategories()

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, CrimesEndpoint.categories(date: Date()).path)
    }

    func testCrimeCategoriesWhenCachedReturnsCachedCrimeCategories() async throws {
        let expectedResult = CrimeCategory.mocks
        let date = Date()
        let cacheKey = CrimeCategoriesCachingKey(date: date)
        await cache.set(expectedResult, for: cacheKey)

        let result = try await service.crimeCategories(forDate: date)

        XCTAssertEqual(result, expectedResult)
        XCTAssertNil(apiClient.lastPath)
    }

    func testCrimeCategoriesWhenNotCachedReturnsCrimeCategoriesShouldCacheResult() async throws {
        let expectedResult = CrimeCategory.mocks
        let date = Date()
        let cacheKey = CrimeCategoriesCachingKey(date: date)
        apiClient.response = .success(expectedResult)
        _ = try await service.crimeCategories(forDate: date)

        let cachedResult = await cache.object(for: cacheKey, type: [CrimeCategory].self)

        XCTAssertEqual(cachedResult, expectedResult)
    }

}
