@testable import PoliceAPI
import XCTest

final class ContactDetailsTests: XCTestCase {

    func testDecodeReturnsContactDetails() throws {
        let result = try JSONDecoder.policeDataAPI.decode(ContactDetails.self, fromResource: "contact-details")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeWhenNoItemsReturnsContactDetails() throws {
        let result = try JSONDecoder.policeDataAPI.decode(ContactDetails.self, fromResource: "contact-details-none")

        XCTAssertEqual(result, .mockNone)
    }

}
