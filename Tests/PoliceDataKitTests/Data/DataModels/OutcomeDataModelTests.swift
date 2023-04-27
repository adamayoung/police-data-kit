@testable import PoliceAPI
import XCTest

final class OutcomeDataModelTests: XCTestCase {

    func testDecodeReturnsOutcome() throws {
        let result = try JSONDecoder.policeDataAPI.decode(OutcomeDataModel.self, fromResource: "outcome")

        XCTAssertEqual(result, .mock)
    }

}
