@testable import PoliceDataKit
import XCTest

final class OutcomeCategoryDataModelTests: XCTestCase {

    func testDecodeReturnsCrimeOutcomeCategory() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(OutcomeCategoryDataModel.self, fromResource: "outcome-category")

        XCTAssertEqual(result, .mock)
    }

}
