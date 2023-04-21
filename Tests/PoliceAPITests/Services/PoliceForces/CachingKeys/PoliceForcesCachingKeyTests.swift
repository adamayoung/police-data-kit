@testable import PoliceAPI
import XCTest

final class PoliceForcesCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let cacheKey = PoliceForcesCachingKey()

        XCTAssertEqual(cacheKey.keyValue, "police-forces")
    }

}
