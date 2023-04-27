@testable import PoliceDataKit
import XCTest

final class OutcomesForCrimeCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let crimeID = "ABC123"
        let cacheKey = OutcomesForCrimeCachingKey(crimeID: crimeID)

        XCTAssertEqual(cacheKey.keyValue, "outcomes-for-crime-\(crimeID)")
    }

}
