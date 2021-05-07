@testable import UKPoliceData
import XCTest

final class LinkTests: XCTestCase {

    func testDecodeReturnsLink() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Link.self, fromResource: "link", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeWhenNoDescriptionReturnsLink() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Link.self, fromResource: "link-no-description", withExtension: "json")

        XCTAssertEqual(result, .mockNoDescription)
    }

}
