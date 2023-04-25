@testable import PoliceAPIData
import XCTest

final class OutcomeCrimeDataModelTests: XCTestCase {

    func testDecodeReturnsCrimeOutcomeCrime() throws {
        let result = try JSONDecoder.policeDataAPI.decode(OutcomeCrimeDataModel.self, fromResource: "outcome-crime")

        XCTAssertEqual(result, .mock)
    }

}
