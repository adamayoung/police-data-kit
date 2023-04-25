@testable import PoliceAPIData
import XCTest

final class CrimesWithNoLocationForCategoryInPoliceForceCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let categoryID = "ABC123"
        let policeForceID = "leicestershire"
        let date = Date(timeIntervalSince1970: 0)
        let cacheKey = CrimesWithNoLocationForCategoryInPoliceForceCachingKey(categoryID: categoryID,
                                                                              policeForceID: policeForceID, date: date)

        XCTAssertEqual(
            cacheKey.keyValue,
            "crimes-with-no-location-in-category-\(categoryID)-police-force-\(policeForceID)-date-1970-01"
        )
    }

}
