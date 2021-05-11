@testable import UKPoliceData
import XCTest

final class CrimeCategoryTests: XCTestCase {

    func testDecodeReturnsCrimeCategory() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(CrimeCategory.self, fromResource: "crime-category", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
