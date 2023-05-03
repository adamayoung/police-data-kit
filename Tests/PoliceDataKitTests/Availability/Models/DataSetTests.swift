@testable import PoliceDataKit
import XCTest

final class DataSetTests: XCTestCase {

    func testDecodeReturnsDataSet() throws {
        let result = try JSONDecoder.policeDataAPI.decode(DataSet.self, fromResource: "data-set")

        XCTAssertEqual(result, .mock)
    }

}
