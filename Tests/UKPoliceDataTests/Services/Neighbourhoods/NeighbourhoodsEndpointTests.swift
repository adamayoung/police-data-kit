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

}
