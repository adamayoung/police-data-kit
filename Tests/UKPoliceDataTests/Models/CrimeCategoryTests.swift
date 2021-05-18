@testable import UKPoliceData
import XCTest

class CrimeCategoryTests: XCTestCase {

    func testDecodeReturnsCrimeCategory() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(CrimeCategory.self, fromResource: "crime-category", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
