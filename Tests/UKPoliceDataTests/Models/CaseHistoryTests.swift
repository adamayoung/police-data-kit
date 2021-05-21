@testable import UKPoliceData
import XCTest

class CaseHistoryTests: XCTestCase {

    func testDecodeReturnsCaseHistory() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(CaseHistory.self, fromResource: "case-history", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
