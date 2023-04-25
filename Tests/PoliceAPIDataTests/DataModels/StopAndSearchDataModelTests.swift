@testable import PoliceAPIData
import XCTest

final class StopAndSearchDataModelTests: XCTestCase {

    func testDecodeReturnsStopAndSearch() throws {
        let result = try JSONDecoder.policeDataAPI.decode(StopAndSearchDataModel.self, fromResource: "stop-and-search")

        XCTAssertEqual(result, .mock)
    }

}
