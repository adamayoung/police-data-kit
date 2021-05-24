@testable import UKPoliceData
import XCTest

class LinkTests: XCTestCase {

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

    func testDecodeWhenURLIsEmptyStringReturnsLink() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Link.self, fromResource: "link-empty-url", withExtension: "json")

        XCTAssertEqual(result, .mockNilURL)
    }

    func testURLWhenURLIsEmptyReturnsNil() {
        let link = Link(title: "Title", description: "Description", url: nil)

        XCTAssertNil(link.url)
    }

}
