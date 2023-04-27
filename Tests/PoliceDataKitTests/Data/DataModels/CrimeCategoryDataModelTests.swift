@testable import PoliceAPI
import XCTest

final class CrimeCategoryDataModelTests: XCTestCase {

    func testDecodeReturnsCrimeCategory() throws {
        let result = try JSONDecoder.policeDataAPI.decode(CrimeCategoryDataModel.self, fromResource: "crime-category")

        XCTAssertEqual(result, .mock)
    }

}
