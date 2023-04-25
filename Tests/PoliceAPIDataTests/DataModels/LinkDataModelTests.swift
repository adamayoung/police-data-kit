@testable import PoliceAPIData
import XCTest

final class LinkDataModelTests: XCTestCase {

    func testDecodeReturnsLink() throws {
        let result = try JSONDecoder.policeDataAPI.decode(LinkDataModel.self, fromResource: "link")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeWhenNoDescriptionReturnsLink() throws {
        let result = try JSONDecoder.policeDataAPI.decode(LinkDataModel.self, fromResource: "link-no-description")

        XCTAssertEqual(result, .mockNoDescription)
    }

    func testDecodeWhenURLIsEmptyStringReturnsLink() throws {
        let result = try JSONDecoder.policeDataAPI.decode(LinkDataModel.self, fromResource: "link-empty-url")

        XCTAssertEqual(result, .mockNilURL)
    }

    func testURLWhenURLIsEmptyReturnsNil() {
        let link = LinkDataModel(title: "Title", description: "Description", url: nil)

        XCTAssertNil(link.url)
    }

}
