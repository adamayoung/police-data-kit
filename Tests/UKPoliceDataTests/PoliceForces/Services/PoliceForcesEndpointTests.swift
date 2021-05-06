@testable import UKPoliceData
import XCTest

class PoliceForcesEndpointTests: XCTestCase {

    func testListEndpointReturnsURL() {
        let expectedURL = URL(string: "/forces")!

        let url = PoliceForcesEndpoint.list.url

        XCTAssertEqual(url, expectedURL)
    }

    func testDetailsEndpointReturnsURL() {
        let expectedURL = URL(string: "/forces/leicestershire")!

        let url = PoliceForcesEndpoint.details(id: "leicestershire").url

        XCTAssertEqual(url, expectedURL)
    }

    func testSeniorOfficersEndpointReturnsURL() {
        let expectedURL = URL(string: "/forces/leicestershire/people")!

        let url = PoliceForcesEndpoint.seniorOfficers(policeForceID: "leicestershire").url

        XCTAssertEqual(url, expectedURL)
    }

}
