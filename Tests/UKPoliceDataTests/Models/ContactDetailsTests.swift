@testable import UKPoliceData
import XCTest

class ContactDetailsTests: XCTestCase {

    func testDecodeReturnsContactDetails() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(ContactDetails.self, fromResource: "contact-details", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeWhenNoItemsReturnsContactDetails() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(ContactDetails.self, fromResource: "contact-details-none", withExtension: "json")

        XCTAssertEqual(result, .mockNone)
    }

}
