@testable import UKPoliceData
import XCTest

final class EngagementMethodTests: XCTestCase {

    func testDecodeReturnsFacebookEngagementMethod() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(EngagementMethod.self, fromResource: "engagement-method-facebook", withExtension: "json")

        XCTAssertEqual(result, .mockFacebook)
    }

    func testDecodeReturnsTwitterEngagementMethod() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(EngagementMethod.self, fromResource: "engagement-method-twitter", withExtension: "json")

        XCTAssertEqual(result, .mockTwitter)
    }

    func testDecodeReturnsYouTubeEngagementMethod() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(EngagementMethod.self, fromResource: "engagement-method-youtube", withExtension: "json")

        XCTAssertEqual(result, .mockYouTube)
    }

    func testDecodeReturnsRSSEngagementMethod() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(EngagementMethod.self, fromResource: "engagement-method-rss", withExtension: "json")

        XCTAssertEqual(result, .mockRSS)
    }

}
