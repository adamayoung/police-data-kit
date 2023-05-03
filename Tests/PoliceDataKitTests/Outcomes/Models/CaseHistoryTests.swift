@testable import PoliceDataKit
import XCTest

final class CaseHistoryTests: XCTestCase {

    func testDecodeReturnsCaseHistory() throws {
        let result = try JSONDecoder.policeDataAPI.decode(CaseHistory.self, fromResource: "case-history")

        XCTAssertEqual(result, .mock)
    }

}
