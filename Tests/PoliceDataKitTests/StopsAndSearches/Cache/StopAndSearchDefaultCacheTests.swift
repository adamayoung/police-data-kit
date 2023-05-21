@testable import PoliceDataKit
import XCTest

final class StopAndSearchDefaultCacheTests: XCTestCase {

    var cache: StopAndSearchDefaultCache!
    var cacheStore: MockCache!

    override func setUp() {
        super.setUp()
        cacheStore = MockCache()
        cache = StopAndSearchDefaultCache(cacheStore: cacheStore)
    }

    override func tearDown() {
        cache = nil
        cacheStore = nil
        super.tearDown()
    }

    func testStopAndSearchesAtLocationWhenMissReturnsNil() async {
        let streetID = 1
        let date = Date()

        let result = await cache.stopAndSearches(atLocation: streetID, date: date)

        XCTAssertNil(result)
    }

    func testStopAndSearchesAtLocationWhenHitReturnsStopAndSearches() async {
        let streetID = 1
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.stopAndSearches(atLocation: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
    }

    func testSetStopAndSearchesAtLocationSetsStopAndSearches() async {
        let streetID = 1
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)

        await cache.setStopAndSearches(expectedResult, atLocation: streetID, date: date)
        let result = await cacheStore.object(for: cacheKey, type: [StopAndSearch].self)

        XCTAssertEqual(result, expectedResult)
    }

    func testStopAndSearchesWithNoLocationWhenMissReturnsNil() async {
        let policeForceID = "test-police-force"
        let date = Date()

        let result = await cache.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        XCTAssertNil(result)
    }

    func testStopAndSearchesWithNoLocationWhenHitReturnsStopAndSearches() async {
        let policeForceID = "test-police-force"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.stopAndSearchesWithNoLocation(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
    }

    func testSetStopAndSearchesWithNoLocationSetsStopAndSearches() async {
        let policeForceID = "test-police-force"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)

        await cache.setStopAndSearchesWithNoLocation(expectedResult, forPoliceForce: policeForceID, date: date)
        let result = await cacheStore.object(for: cacheKey, type: [StopAndSearch].self)

        XCTAssertEqual(result, expectedResult)
    }

    func testStopAndSearchesForPoliceForceWhenMissReturnsNil() async {
        let policeForceID = "test-police-force"
        let date = Date()

        let result = await cache.stopAndSearches(forPoliceForce: policeForceID, date: date)

        XCTAssertNil(result)
    }

    func testStopAndSearchesForPoliceForceWhenHitReturnsStopAndSearches() async {
        let policeForceID = "test-police-force"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.stopAndSearches(forPoliceForce: policeForceID, date: date)

        XCTAssertEqual(result, expectedResult)
    }

    func testSetStopAndSearchesForPoliceForceSetsStopAndSearches() async {
        let policeForceID = "test-police-force"
        let date = Date()
        let expectedResult = StopAndSearch.mocks
        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)

        await cache.setStopAndSearches(expectedResult, forPoliceForce: policeForceID, date: date)
        let result = await cacheStore.object(for: cacheKey, type: [StopAndSearch].self)

        XCTAssertEqual(result, expectedResult)
    }

}
