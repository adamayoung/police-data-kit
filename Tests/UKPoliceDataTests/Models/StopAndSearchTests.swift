@testable import UKPoliceData
import XCTest

class StopAndSearchTests: XCTestCase {

    func testDecodeReturnsStopAndSearch() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(StopAndSearch.self, fromResource: "stop-and-search", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
