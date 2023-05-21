@testable import PoliceDataKit
import XCTest

final class PoliceForceDefaultCacheTests: XCTestCase {

    var cache: PoliceForceDefaultCache!
    var cacheStore: MockCache!

    override func setUp() {
        super.setUp()
        cacheStore = MockCache()
        cache = PoliceForceDefaultCache(cacheStore: cacheStore)
    }

    override func tearDown() {
        cache = nil
        cacheStore = nil
        super.tearDown()
    }

    func testPoliceForcesWhenMissReturnsNil() async {
        let result = await cache.policeForces()

        XCTAssertNil(result)
    }

    func testPoliceForcesWhenHitReturnsPoliceForces() async {
        let expectedResult = PoliceForceReference.mocks
        let cacheKey = PoliceForcesCachingKey()
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.policeForces()

        XCTAssertEqual(result, expectedResult)
    }

    func testSetPoliceForcesSetsPoliceForces() async {
        let expectedResult = PoliceForceReference.mocks
        let cacheKey = PoliceForcesCachingKey()

        await cache.setPoliceForces(expectedResult)
        let result = await cacheStore.object(for: cacheKey, type: [PoliceForceReference].self)

        XCTAssertEqual(result, expectedResult)
    }

    func testPoliceForceWhenMissReturnsNil() async {
        let policeForceID = "test-police-force"
        let result = await cache.policeForce(withID: policeForceID)

        XCTAssertNil(result)
    }

    func testPoliceForceWhenHitReturnsPoliceForce() async {
        let policeForceID = "test-police-force"
        let expectedResult = PoliceForce.mock
        let cacheKey = PoliceForceCachingKey(id: policeForceID)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.policeForce(withID: policeForceID)

        XCTAssertEqual(result, expectedResult)
    }

    func testSetPoliceForceSetsPoliceForce() async {
        let policeForceID = "test-police-force"
        let expectedResult = PoliceForce.mock
        let cacheKey = PoliceForceCachingKey(id: policeForceID)

        await cache.setPoliceForce(expectedResult, withID: policeForceID)
        let result = await cacheStore.object(for: cacheKey, type: PoliceForce.self)

        XCTAssertEqual(result, expectedResult)
    }

    func testSeniorOfficersWhenMissReturnsNil() async {
        let policeForceID = "test-police-force"
        let result = await cache.seniorOfficers(inPoliceForce: policeForceID)

        XCTAssertNil(result)
    }

    func testSeniorOfficersWhenWhenHitReturnsSeniorOfficers() async {
        let policeForceID = "test-police-force"
        let expectedResult = PoliceOfficer.mocks
        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.seniorOfficers(inPoliceForce: policeForceID)

        XCTAssertEqual(result, expectedResult)
    }

    func testSetSeniorOfficersSetsSeniorOfficers() async {
        let policeForceID = "test-police-force"
        let expectedResult = PoliceOfficer.mocks
        let cacheKey = PoliceForceSeniorOfficersCachingKey(policeForceID: policeForceID)

        await cache.setSeniorOfficers(expectedResult, inPoliceForce: policeForceID)
        let result = await cacheStore.object(for: cacheKey, type: [PoliceOfficer].self)

        XCTAssertEqual(result, expectedResult)
    }

}
