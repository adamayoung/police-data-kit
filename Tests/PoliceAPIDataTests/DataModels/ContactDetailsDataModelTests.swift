@testable import PoliceAPIData
import XCTest

final class ContactDetailsDataModelTests: XCTestCase {

    func testDecodeReturnsContactDetails() throws {
        let result = try JSONDecoder.policeDataAPI.decode(ContactDetailsDataModel.self, fromResource: "contact-details")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeWhenNoItemsReturnsContactDetails() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(ContactDetailsDataModel.self, fromResource: "contact-details-none")

        XCTAssertEqual(result, .mockNone)
    }

}
