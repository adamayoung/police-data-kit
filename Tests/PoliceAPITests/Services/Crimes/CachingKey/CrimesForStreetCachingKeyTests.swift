@testable import PoliceAPI
import XCTest

final class CrimesForStreetCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let streetID = 123
        let date = Date(timeIntervalSince1970: 0)
        let cacheKey = CrimesForStreetCachingKey(streetID: streetID, date: date)

        XCTAssertEqual(cacheKey.keyValue, "crimes-for-street-\(streetID)-date-1970-01")
    }

}
