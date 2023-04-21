@testable import PoliceAPI
import XCTest

final class AvailableDataSetsCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let cacheKey = AvailableDataSetsCachingKey()

        XCTAssertEqual(cacheKey.keyValue, "available-data-sets")
    }

}
