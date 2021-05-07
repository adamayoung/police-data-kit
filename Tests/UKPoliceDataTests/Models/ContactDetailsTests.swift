@testable import UKPoliceData
import XCTest

final class ContactDetailsTests: XCTestCase {

    func testDecodeReturnsContactDetails() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(ContactDetails.self, fromResource: "contact-details", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
