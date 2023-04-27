@testable import PoliceDataKit
import XCTest

final class CrimeLocationTypeDataModelTests: XCTestCase {

    func testDecodeReturnsCrimeLocation() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode([CrimeLocationTypeDataModel].self, fromResource: "crime-location-types")

        XCTAssertEqual(result, CrimeLocationTypeDataModel.mocks)
    }

}
