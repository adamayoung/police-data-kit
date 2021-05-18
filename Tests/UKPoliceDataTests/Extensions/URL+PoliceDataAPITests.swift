@testable import UKPoliceData
import XCTest

class URLPoliceDataAPITests: XCTestCase {

    func testPoliceDataAPIBaseURLReturnsURL() {
        let expectedResult = URL(string: "https://data.police.uk/api")!

        let result = URL.policeDataAPIBaseURL

        XCTAssertEqual(result, expectedResult)
    }

}
