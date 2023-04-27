@testable import PoliceDataKit
import XCTest

final class OutcomesAtStreetLevelForStreetCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let streetID = 123
        let date = Date(timeIntervalSince1970: 0)
        let cacheKey = OutcomesAtStreetLevelForStreetCachingKey(streetID: streetID, date: date)

        XCTAssertEqual(cacheKey.keyValue, "outcomes-street-level-for-street-\(streetID)-date-1970-01")
    }

}
