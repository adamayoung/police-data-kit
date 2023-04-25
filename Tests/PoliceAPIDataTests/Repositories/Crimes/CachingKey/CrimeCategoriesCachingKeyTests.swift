@testable import PoliceAPIData
import XCTest

final class CrimeCategoriesCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let date = Date(timeIntervalSince1970: 0)
        let cacheKey = CrimeCategoriesCachingKey(date: date)

        XCTAssertEqual(cacheKey.keyValue, "crime-categories-date-1970-01")
    }

}
