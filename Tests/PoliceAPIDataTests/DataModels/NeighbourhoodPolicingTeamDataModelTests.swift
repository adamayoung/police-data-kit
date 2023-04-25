@testable import PoliceAPIData
import XCTest

final class NeighbourhoodPolicingTeamDataModelTests: XCTestCase {

    func testDecodeReturnsNeighbourhoodPolicingTeam() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPolicingTeamDataModel.self, fromResource: "neighbourhood-policing-team")

        XCTAssertEqual(result, .mock)
    }

}
