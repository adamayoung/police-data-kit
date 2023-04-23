@testable import PoliceAPI
import XCTest

final class PoliceForcesEndpointTests: XCTestCase {

    func testListEndpointReturnsURL() throws {
        let expectedPath = try XCTUnwrap(URL(string: "/forces"))

        let path = PoliceForcesEndpoint.list.path

        XCTAssertEqual(path, expectedPath)
    }

    func testDetailsEndpointReturnsURL() throws {
        let id = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/forces/\(id)"))

        let path = PoliceForcesEndpoint.details(id: id).path

        XCTAssertEqual(path, expectedPath)
    }

    func testSeniorOfficersEndpointReturnsURL() throws {
        let policeForceID = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/forces/\(policeForceID)/people"))

        let path = PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

}
