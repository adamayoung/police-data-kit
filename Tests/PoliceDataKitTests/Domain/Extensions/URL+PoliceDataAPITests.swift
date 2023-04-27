@testable import PoliceDataKit
import XCTest

final class URLPoliceDataAPITests: XCTestCase {

    func testPoliceDataAPIBaseURLReturnsURL() throws {
        let expectedResult = try XCTUnwrap(URL(string: "https://data.police.uk/api"))

        let result = URL.policeDataAPIBaseURL

        XCTAssertEqual(result, expectedResult)
    }

}
