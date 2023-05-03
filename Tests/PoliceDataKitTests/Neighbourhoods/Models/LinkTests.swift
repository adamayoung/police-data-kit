@testable import PoliceDataKit
import XCTest

final class LinkTests: XCTestCase {

    func testDecodeReturnsLink() throws {
        let result = try JSONDecoder.policeDataAPI.decode(Link.self, fromResource: "link")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeWhenNoDescriptionReturnsLink() throws {
        let result = try JSONDecoder.policeDataAPI.decode(Link.self, fromResource: "link-no-description")

        XCTAssertEqual(result, .mockNoDescription)
    }

    func testURLWhenURLIsEmptyReturnsNil() {
        let link = Link(title: "Title", description: "Description", url: nil)

        XCTAssertNil(link.url)
    }

}
