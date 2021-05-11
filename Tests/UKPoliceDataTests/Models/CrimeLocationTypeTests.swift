@testable import UKPoliceData
import XCTest

final class CrimeLocationTypeTests: XCTestCase {

    func testDecodeReturnsCrimeLocation() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode([CrimeLocationType].self, fromResource: "crime-location-types", withExtension: "json")

        XCTAssertEqual(result, CrimeLocationType.mocks)
    }

    func testDescriptionReturnsForceDescription() {
        let expectedResult = "Police Force"

        let result = CrimeLocationType.force.description

        XCTAssertEqual(result, expectedResult)
    }

    func testDescriptionReturnsBTPDescription() {
        let expectedResult = "British Transport Police"

        let result = CrimeLocationType.btp.description

        XCTAssertEqual(result, expectedResult)
    }

}
