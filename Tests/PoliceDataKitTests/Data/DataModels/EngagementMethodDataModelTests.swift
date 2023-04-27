@testable import PoliceDataKit
import XCTest

final class EngagementMethodDataModelTests: XCTestCase {

    func testDecodeReturnsEngagementMethod() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(EngagementMethodDataModel.self, fromResource: "engagement-method")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeReturnsEngagementMethodWithURL() throws {
        let engagementMethod = try JSONDecoder.policeDataAPI
            .decode(EngagementMethodDataModel.self, fromResource: "engagement-method")

        let result = engagementMethod.url

        XCTAssertEqual(result, EngagementMethodDataModel.mock.url)
    }

}
