@testable import PoliceDataKit
import XCTest

final class CrimeDataModelTests: XCTestCase {

    func testDecodeReturnsCrime() throws {
        let result = try JSONDecoder.policeDataAPI.decode(CrimeDataModel.self, fromResource: "crime")

        XCTAssertEqual(result, .mock)
    }

}
