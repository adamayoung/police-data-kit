@testable import PoliceAPI
import XCTest

final class CrimeLocationTypeDataModelTests: XCTestCase {

    func testDecodeReturnsCrimeLocation() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode([CrimeLocationTypeDataModel].self, fromResource: "crime-location-types")

        XCTAssertEqual(result, CrimeLocationTypeDataModel.mocks)
    }

    func testDescriptionReturnsForceDescription() {
        let expectedResult = "Police Force"

        let result = CrimeLocationTypeDataModel.force.description

        XCTAssertEqual(result, expectedResult)
    }

    func testDescriptionReturnsBTPDescription() {
        let expectedResult = "British Transport Police"

        let result = CrimeLocationTypeDataModel.btp.description

        XCTAssertEqual(result, expectedResult)
    }

}
