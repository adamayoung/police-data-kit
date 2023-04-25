@testable import PoliceAPIData
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

    func testDecodeWithEmptyURLReturnsEngagementMethod() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(EngagementMethodDataModel.self, fromResource: "engagement-method-empty-url")

        XCTAssertEqual(result, .mockNoURL)
    }

    func testDecodeWithEmptyURLReturnsEngagementMethodWithNilURL() throws {
        let engagementMethod = try JSONDecoder.policeDataAPI
            .decode(EngagementMethodDataModel.self, fromResource: "engagement-method-empty-url")

        let result = engagementMethod.url

        XCTAssertNil(result)
    }

}
