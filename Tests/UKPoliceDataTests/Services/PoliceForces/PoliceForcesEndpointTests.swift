@testable import UKPoliceData
import XCTest

final class PoliceForcesEndpointTests: XCTestCase {

    func testListEndpointReturnsURL() {
        let expectedPath = URL(string: "/forces")!

        let path = PoliceForcesEndpoint.list.path

        XCTAssertEqual(path, expectedPath)
    }

    func testDetailsEndpointReturnsURL() {
        let id = "leicestershire"
        let expectedPath = URL(string: "/forces/\(id)")!

        let path = PoliceForcesEndpoint.details(id: id).path

        XCTAssertEqual(path, expectedPath)
    }

    func testSeniorOfficersEndpointReturnsURL() {
        let policeForceID = "leicestershire"
        let expectedPath = URL(string: "/forces/\(policeForceID)/people")!

        let path = PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

}
