@testable import PoliceDataKit
import XCTest

final class AvailabilityDefaultCacheTests: XCTestCase {

    var cache: AvailabilityDefaultCache!
    var cacheStore: MockCache!

    override func setUp() {
        super.setUp()
        cacheStore = MockCache()
        cache = AvailabilityDefaultCache(cacheStore: cacheStore)
    }

    override func tearDown() {
        cache = nil
        cacheStore = nil
        super.tearDown()
    }

    func testAvailableDataSetsWhenMissReturnsNil() async {
        let result = await cache.availableDataSets()

        XCTAssertNil(result)
    }

    func testAvailableDataSetsWhenHotReturnsAvailableDataSets() async {
        let cacheKey = AvailableDataSetsCachingKey()
        let expectedResult = DataSet.mocks
        await cacheStore.set(expectedResult, for: cacheKey)

        let result = await cache.availableDataSets()

        XCTAssertEqual(result, expectedResult)
    }

    func testSetAvailableDataSetsAvailableDataSets() async {
        let cacheKey = AvailableDataSetsCachingKey()
        let expectedResult = DataSet.mocks

        await cache.setAvailableDataSets(expectedResult)
        let result = await cacheStore.object(for: cacheKey, type: [DataSet].self)

        XCTAssertEqual(result, expectedResult)
    }

}
