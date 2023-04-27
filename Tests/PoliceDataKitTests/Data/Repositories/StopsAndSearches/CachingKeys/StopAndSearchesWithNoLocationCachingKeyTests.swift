@testable import PoliceAPI
import XCTest

final class StopAndSearchesWithNoLocationCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let policeForceID = "leicestershire"
        let date = Date(timeIntervalSince1970: 0)

        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)

        XCTAssertEqual(
            cacheKey.keyValue,
            "stop-and-searches-with-no-location-for-police-force-\(policeForceID)-date-1970-01"
        )
    }

}
