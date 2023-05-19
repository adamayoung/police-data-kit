import CoreLocation
@testable import PoliceDataKit
import XCTest

final class CrimeDefaultCacheTests: XCTestCase {

    var cache: CrimeDefaultCache!
    var cacheStore: MockCache!

    override func setUp() {
        super.setUp()
        cacheStore = MockCache()
        cache = CrimeDefaultCache(cacheStore: cacheStore)
    }

    override func tearDown() {
        cache = nil
        cacheStore = nil
        super.tearDown()
    }

    func testCrimesForStreetWhenMissReturnsNil() async {
        let streetID = 1
        let date = Date()

        let result = await cache.crimes(forStreet: streetID, date: date)

        XCTAssertNil(result)
    }

    func testCrimesForStreetWhenHitReturnsCrimes() async {
        let streetID = 1
        let date = Date()
        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)
        let expectedResult = Crime.mocks
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.crimes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
    }

    func testSetCrimesForStreetSetsCrimes() async {
        let streetID = 1
        let date = Date()
        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)
        let expectedResult = Crime.mocks

        await cache.setCrimes(expectedResult, forStreet: streetID, date: date)
        let result = await cacheStore.object(for: cacheKey, type: [Crime].self)

        XCTAssertEqual(result, expectedResult)
    }

    func testCrimesWithNoLocationWhenMissReturnsNil() async {
        let categoryID = "test-crime"
        let policeForceID = "test-police-force"
        let date = Date()

        let result = await cache.crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID, date: date)

        XCTAssertNil(result)
    }

    func testCrimesWithNoLocationWhenHitReturnsCrimes() async {
        let categoryID = "test-crime"
        let policeForceID = "test-police-force"
        let date = Date()
        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(categoryID: categoryID,
                                                                              policeForceID: policeForceID, date: date)
        let expectedResult = Crime.mocks
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.crimesWithNoLocation(forCategory: categoryID, inPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
    }

    func testCrimesWithNoLocationSetsCrimes() async {
        let categoryID = "test-crime"
        let policeForceID = "test-police-force"
        let date = Date()
        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(categoryID: categoryID,
                                                                              policeForceID: policeForceID, date: date)
        let expectedResult = Crime.mocks

        await cache.setCrimesWithNoLocation(expectedResult, forCategory: categoryID, inPoliceForce: policeForceID,
                                            date: date)
        let result = await cacheStore.object(for: cacheKey, type: [Crime].self)

        XCTAssertEqual(result, expectedResult)
    }

    func testCrimeCategoriesWhenMissReturnsNil() async {
        let date = Date()

        let result = await cache.crimeCategories(forDate: date)

        XCTAssertNil(result)
    }

    func testCrimeCategoriesWhenHitReturnsCrimeCategories() async {
        let date = Date()
        let cacheKey = CrimeCategoriesCachingKey(date: date)
        let expectedResult = CrimeCategory.mocks
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.crimeCategories(forDate: date)

        XCTAssertEqual(result, expectedResult)
    }

    func testSetCrimeCategoriesSetsCrimeCategories() async {
        let date = Date()
        let cacheKey = CrimeCategoriesCachingKey(date: date)
        let expectedResult = CrimeCategory.mocks

        await cache.setCrimeCategories(expectedResult, forDate: date)
        let result = await cacheStore.object(for: cacheKey, type: [CrimeCategory].self)

        XCTAssertEqual(result, expectedResult)
    }

}
