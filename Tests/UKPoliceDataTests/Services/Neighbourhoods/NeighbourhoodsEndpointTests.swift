@testable import UKPoliceData
import XCTest

final class NeighbourhoodsEndpointTests: XCTestCase {

    func testListEndpointReturnsURL() {
        let policeForceID = "leicestershire"
        let expectedPath = URL(string: "/\(policeForceID)/neighbourhoods")!

        let path = NeighbourhoodsEndpoint.list(policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testDetailsEndpointReturnsURL() {
        let id = "AB123"
        let policeForceID = "leicestershire"
        let expectedPath = URL(string: "/\(policeForceID)/\(id)")!

        let path = NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testBoundaryEndpointReturnsURL() {
        let neighbourhoodID = "AB123"
        let policeForceID = "leicestershire"
        let expectedPath = URL(string: "/\(policeForceID)/\(neighbourhoodID)/boundary")!

        let path = NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

    func testTeamEndpointReturnsURL() {
        let neighbourhoodID = "AB123"
        let policeForceID = "leicestershire"
        let expectedPath = URL(string: "/\(policeForceID)/\(neighbourhoodID)/people")!

        let path = NeighbourhoodsEndpoint.policeOfficers(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
            .path

        XCTAssertEqual(path, expectedPath)
    }

    func testPrioritiesEndpointReturnsURL() {
        let neighbourhoodID = "AB123"
        let policeForceID = "leicestershire"
        let expectedPath = URL(string: "/\(policeForceID)/\(neighbourhoodID)/priorities")!

        let path = NeighbourhoodsEndpoint.priorities(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
            .path

        XCTAssertEqual(path, expectedPath)
    }

    func testLocateNeighbourhoodReturnsURL() {
        let coordinate = Coordinate.mock
        let expectedPath = URL(string: "/locate-neighbourhood?q=\(coordinate.latitude),\(coordinate.longitude)")!

        let path = NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).path

        XCTAssertEqual(path, expectedPath)
    }

}
