@testable import UKPoliceData
import XCTest

final class EngagementMethodTests: XCTestCase {

    func testDecodeReturnsEngagementMethod() throws {
        let result = try JSONDecoder.policeDataAPI.decode(EngagementMethod.self, fromResource: "engagement-method")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeReturnsEngagementMethodWithURL() throws {
        let engagementMethod = try JSONDecoder.policeDataAPI
            .decode(EngagementMethod.self, fromResource: "engagement-method")

        let result = engagementMethod.url

        XCTAssertEqual(result, EngagementMethod.mock.url)
    }

    func testDecodeWithEmptyURLReturnsEngagementMethod() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(EngagementMethod.self, fromResource: "engagement-method-empty-url")

        XCTAssertEqual(result, .mockNoURL)
    }

    func testDecodeWithEmptyURLReturnsEngagementMethodWithNilURL() throws {
        let engagementMethod = try JSONDecoder.policeDataAPI
            .decode(EngagementMethod.self, fromResource: "engagement-method-empty-url")

        let result = engagementMethod.url

        XCTAssertNil(result)
    }

}
