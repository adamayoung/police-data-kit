@testable import PoliceDataKit
import XCTest

final class StopAndSearchesForPoliceForceCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let policeForceID = "leicestershire"
        let date = Date(timeIntervalSince1970: 0)

        let cacheKey = StopAndSearchesForPoliceForceCachingKey(policeForceID: policeForceID, date: date)

        XCTAssertEqual(cacheKey.keyValue, "stop-and-searches-for-police-force-\(policeForceID)-date-1970-01")
    }

}
