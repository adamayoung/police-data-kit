@testable import UKPoliceData
import XCTest

class NeighbourhoodsEndpointTests: XCTestCase {

    func testListEndpointReturnsURL() {
        let policeForceID = "leicestershire"
        let expectedURL = URL(string: "/\(policeForceID)/neighbourhoods")!

        let url = NeighbourhoodsEndpoint.list(policeForceID: policeForceID).url

        XCTAssertEqual(url, expectedURL)
    }

    func testDetailsEndpointReturnsURL() {
        let id = "AB123"
        let policeForceID = "leicestershire"
        let expectedURL = URL(string: "/\(policeForceID)/\(id)")!

        let url = NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID).url

        XCTAssertEqual(url, expectedURL)
    }

    func testBoundaryEndpointReturnsURL() {
        let neighbourhoodID = "AB123"
        let policeForceID = "leicestershire"
        let expectedURL = URL(string: "/\(policeForceID)/\(neighbourhoodID)/boundary")!

        let url = NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID).url

        XCTAssertEqual(url, expectedURL)
    }

    func testTeamEndpointReturnsURL() {
        let neighbourhoodID = "AB123"
        let policeForceID = "leicestershire"
        let expectedURL = URL(string: "/\(policeForceID)/\(neighbourhoodID)/people")!

        let url = NeighbourhoodsEndpoint.policeOfficers(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID)
            .url

        XCTAssertEqual(url, expectedURL)
    }

    func testPrioritiesEndpointReturnsURL() {
        let neighbourhoodID = "AB123"
        let policeForceID = "leicestershire"
        let expectedURL = URL(string: "/\(policeForceID)/\(neighbourhoodID)/priorities")!

        let url = NeighbourhoodsEndpoint.priorities(neighbourhoodID: neighbourhoodID, policeForceID: policeForceID).url

        XCTAssertEqual(url, expectedURL)
    }

    func testLocateNeighbourhoodReturnsURL() {
        let coordinate = Coordinate.mock
        let expectedURL = URL(string: "/locate-neighbourhood?q=\(coordinate.latitude),\(coordinate.longitude)")!

        let url = NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).url

        XCTAssertEqual(url, expectedURL)
    }

}
