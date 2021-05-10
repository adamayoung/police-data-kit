@testable import UKPoliceData
import XCTest

final class NeighbourhoodPolicingTeamTests: XCTestCase {

    func testDecodeReturnsNeighbourhoodPolicingTeam() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPolicingTeam.self, fromResource: "neighbourhood-policing-team", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
