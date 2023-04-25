@testable import PoliceAPIData
import XCTest

final class NeighbourhoodsEndpointTests: XCTestCase {

    func testListEndpointReturnsURL() throws {
        let policeForceID = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/\(policeForceID)/neighbourhoods"))

        let path = NeighbourhoodsEndpoint.list(policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testDetailsEndpointReturnsURL() throws {
        let id = "AB123"
        let policeForceID = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/\(policeForceID)/\(id)"))

        let path = NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testBoundaryEndpointReturnsURL() throws {
        let neighbourhoodID = "AB123"
        let policeForceID = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/\(policeForceID)/\(neighbourhoodID)/boundary"))

        let path = NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testTeamEndpointReturnsURL() throws {
        let neighbourhoodID = "AB123"
        let policeForceID = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/\(policeForceID)/\(neighbourhoodID)/people"))

        let path = NeighbourhoodsEndpoint.policeOfficers(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
            .path

        XCTAssertEqual(path, expectedPath)
    }

    func testPrioritiesEndpointReturnsURL() throws {
        let neighbourhoodID = "AB123"
        let policeForceID = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/\(policeForceID)/\(neighbourhoodID)/priorities"))

        let path = NeighbourhoodsEndpoint.priorities(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
            .path

        XCTAssertEqual(path, expectedPath)
    }

    func testLocateNeighbourhoodReturnsURL() throws {
        let coordinate = CoordinateDataModel.mock
        let expectedPath = try XCTUnwrap(URL(
            string: "/locate-neighbourhood?q=\(coordinate.latitude),\(coordinate.longitude)"
        ))

        let path = NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).path

        XCTAssertEqual(path, expectedPath)
    }

}
