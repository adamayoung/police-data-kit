@testable import PoliceAPIData
import XCTest

final class StopAndSearchesAtLocationCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let streetID = 123
        let date = Date(timeIntervalSince1970: 0)

        let cacheKey = StopAndSearchesAtLocationCachingKey(streetID: streetID, date: date)

        XCTAssertEqual(cacheKey.keyValue, "stop-and-searches-at-location-\(streetID)-date-1970-01")
    }

}
