@testable import UKPoliceData
import XCTest

class OutcomeCategoryTests: XCTestCase {

    func testDecodeReturnsCrimeOutcomeCategory() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(OutcomeCategory.self, fromResource: "outcome-category", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
