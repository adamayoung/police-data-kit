@testable import PoliceAPI
import XCTest

final class DataSetDataModelTests: XCTestCase {

    func testDecodeReturnsDataSet() throws {
        let result = try JSONDecoder.policeDataAPI.decode(DataSetDataModel.self, fromResource: "data-set")

        XCTAssertEqual(result, .mock)
    }

}
