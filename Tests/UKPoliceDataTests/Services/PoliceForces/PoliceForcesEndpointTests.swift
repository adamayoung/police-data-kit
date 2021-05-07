@testable import UKPoliceData
import XCTest

class PoliceForcesEndpointTests: XCTestCase {

    func testListEndpointReturnsURL() {
        let expectedURL = URL(string: "/forces")!

        let url = PoliceForcesEndpoint.list.url

        XCTAssertEqual(url, expectedURL)
    }

    func testDetailsEndpointReturnsURL() {
        let id = "leicestershire"
        let expectedURL = URL(string: "/forces/\(id)")!

        let url = PoliceForcesEndpoint.details(id: id).url

        XCTAssertEqual(url, expectedURL)
    }

    func testSeniorOfficersEndpointReturnsURL() {
        let policeForceID = "leicestershire"
        let expectedURL = URL(string: "/forces/\(policeForceID)/people")!

        let url = PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID).url

        XCTAssertEqual(url, expectedURL)
    }

}
