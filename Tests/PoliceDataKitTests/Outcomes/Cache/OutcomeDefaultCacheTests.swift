@testable import PoliceDataKit
import XCTest

final class OutcomeDefaultCacheTests: XCTestCase {

    var cache: OutcomeDefaultCache!
    var cacheStore: MockCache!

    override func setUp() {
        super.setUp()
        cacheStore = MockCache()
        cache = OutcomeDefaultCache(cacheStore: cacheStore)
    }

    override func tearDown() {
        cache = nil
        cacheStore = nil
        super.tearDown()
    }

    func testStreetLevelOutcomesForStreetWhenMissReturnsNil() async {
        let streetID = 1
        let date = Date()
        let result = await cache.streetLevelOutcomes(forStreet: streetID, date: date)

        XCTAssertNil(result)
    }

    func testStreetLevelOutcomesForStreetWhenHitReturnsOutcomes() async {
        let streetID = 1
        let date = Date()
        let expectedResult = Outcome.mocks
        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.streetLevelOutcomes(forStreet: streetID, date: date)

        XCTAssertEqual(result, expectedResult)
    }

    func testSetStreetLevelOutcomesForStreetSetsOutcomes() async {
        let streetID = 1
        let date = Date()
        let expectedResult = Outcome.mocks
        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)

        await cache.setStreetLevelOutcomes(expectedResult, forStreet: streetID, date: date)
        let result = await cacheStore.object(for: cacheKey, type: [Outcome].self)

        XCTAssertEqual(result, expectedResult)
    }

    func testCaseHistoryWhenMissReturnsNil() async {
        let crimeID = "test-crime"
        let result = await cache.caseHistory(forCrime: crimeID)

        XCTAssertNil(result)
    }

    func testCaseHistoryWhenHitReturnsCaseHistory() async {
        let crimeID = "test-crime"
        let expectedResult = CaseHistory.mock
        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.caseHistory(forCrime: crimeID)

        XCTAssertEqual(result, expectedResult)
    }

    func testSetCaseHistorySetsCaseHistory() async {
        let crimeID = "test-crime"
        let expectedResult = CaseHistory.mock
        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)

        await cache.setCaseHistory(expectedResult, forCrime: crimeID)
        let result = await cacheStore.object(for: cacheKey, type: CaseHistory.self)

        XCTAssertEqual(result, expectedResult)
    }

}
