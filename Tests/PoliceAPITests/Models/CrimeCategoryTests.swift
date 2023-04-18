@testable import PoliceAPI
import XCTest

final class CrimeCategoryTests: XCTestCase {

    func testDecodeReturnsCrimeCategory() throws {
        let result = try JSONDecoder.policeDataAPI.decode(CrimeCategory.self, fromResource: "crime-category")

        XCTAssertEqual(result, .mock)
    }

}
