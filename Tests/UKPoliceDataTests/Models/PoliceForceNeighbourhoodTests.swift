@testable import UKPoliceData
import XCTest

class PoliceForceNeighbourhoodTests: XCTestCase {

    func testDecodeReturnsNeighbourhoodPolicingTeam() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(PoliceForceNeighbourhood.self, fromResource: "police-force-neighbourhood", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
