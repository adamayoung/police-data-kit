@testable import UKPoliceData
import XCTest

final class OutcomeCategoryTests: XCTestCase {

    func testDecodeReturnsCrimeOutcomeCategory() throws {
        let result = try JSONDecoder.policeDataAPI.decode(OutcomeCategory.self, fromResource: "outcome-category")

        XCTAssertEqual(result, .mock)
    }

}
