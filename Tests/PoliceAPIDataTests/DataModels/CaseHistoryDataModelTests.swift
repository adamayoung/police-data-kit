@testable import PoliceAPIData
import XCTest

final class CaseHistoryDataModelTests: XCTestCase {

    func testDecodeReturnsCaseHistory() throws {
        let result = try JSONDecoder.policeDataAPI.decode(CaseHistoryDataModel.self, fromResource: "case-history")

        XCTAssertEqual(result, .mock)
    }

}
