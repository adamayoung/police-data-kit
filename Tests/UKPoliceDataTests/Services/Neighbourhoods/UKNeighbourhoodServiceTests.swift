@testable import UKPoliceData
import XCTest

class UKNeighbourhoodServiceTests: XCTestCase {

    var service: UKNeighbourhoodService!
    var apiClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        service = UKNeighbourhoodService(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient = nil
        service = nil
        super.tearDown()
    }

    func testFetchAllReturnsNeighbourhoodReferences() {
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodReference.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchAll(inPoliceForce: policeForceID) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.list(policeForceID: policeForceID).url)
    }

    func testFetchDetailsReturnsNeighbourhood() {
        let expectedResult = Neighbourhood.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchDetails(forNeighbourhood: id, inPoliceForce: policeForceID) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID).url)
    }

    func testFetchBoundaryReturnsCoordinates() {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = Coordinate.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchBoundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID,
                                                                           policeForceID: policeForceID).url)
    }

    func testFetchPeopleOfficersReturnsPoliceOfficers() {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficer.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchPoliceOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.policeOfficers(neighbourhoodID: neighbourhoodID,
                                                                                 policeForceID: policeForceID).url)
    }

    func testFetchPrioritiesReturnsNeighbourhoodPriorities() {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriority.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchPriorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.priorities(neighbourhoodID: neighbourhoodID,
                                                                             policeForceID: policeForceID).url)
    }

    func testFetchNeighbourhoodPolicingTeamAtCoordinateReturnsNeighbourhoodPolicingTeam() {
        let coordinate = Coordinate.mock
        let expectedResult = NeighbourhoodPolicingTeam.mock
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchNeighbourhoodPolicingTeam(atCoordinate: coordinate) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).url)
    }

}
