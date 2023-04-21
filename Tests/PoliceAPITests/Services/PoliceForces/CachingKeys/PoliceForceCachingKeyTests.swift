@testable import PoliceAPI
import XCTest

final class PoliceForceCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let id = "abc123"

        let cacheKey = PoliceForceCachingKey(id: id)

        XCTAssertEqual(cacheKey.keyValue, "police-force-\(id)")
    }

}
