@testable import PoliceDataKit
import XCTest

final class CrimeLocationTypeTests: XCTestCase {

    func testDecodeReturnsCrimeLocation() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode([CrimeLocationType].self, fromResource: "crime-location-types")

        XCTAssertEqual(result, CrimeLocationType.mocks)
    }

}
