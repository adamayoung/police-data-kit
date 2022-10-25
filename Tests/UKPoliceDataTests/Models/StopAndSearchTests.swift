@testable import UKPoliceData
import XCTest

final class StopAndSearchTests: XCTestCase {

    func testDecodeReturnsStopAndSearch() throws {
        let result = try JSONDecoder.policeDataAPI.decode(StopAndSearch.self, fromResource: "stop-and-search")

        XCTAssertEqual(result, .mock)
    }

}
