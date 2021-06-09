#if canImport(Combine)
import Combine
@testable import UKPoliceData
import XCTest

class UKNeighbourhoodServiceCombineTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []
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

    func testNeighbourhoodsPublisherReturnsNeighbourhoodReferences() throws {
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodReference.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.neighbourhoodsPublisher(inPoliceForce: policeForceID),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.list(policeForceID: policeForceID).url)
    }

    func testDetailsPublisherReturnsNeighbourhood() throws {
        let expectedResult = Neighbourhood.mock
        let id = expectedResult.id
        let policeForceID = "leicestershire"
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.detailsPublisher(forNeighbourhood: id,
                                                                     inPoliceForce: policeForceID),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.details(id: id, policeForceID: policeForceID).url)
    }

    func testBoundaryPublisherReturnsCoordinates() throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = Coordinate.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.boundaryPublisher(forNeighbourhood: neighbourhoodID,
                                                                      inPoliceForce: policeForceID),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.boundary(neighbourhoodID: neighbourhoodID,
                                                                           policeForceID: policeForceID).url)
    }

    func testPoliceOfficersPublisherReturnsPoliceOfficers() throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = PoliceOfficer.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.policeOfficersPublisher(forNeighbourhood: neighbourhoodID,
                                                                            inPoliceForce: policeForceID),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.policeOfficers(neighbourhoodID: neighbourhoodID,
                                                                                 policeForceID: policeForceID).url)
    }

    func testPrioritiesPublisherReturnsNeighbourhoodPriorities() throws {
        let neighbourhoodID = "NC04"
        let policeForceID = "leicestershire"
        let expectedResult = NeighbourhoodPriority.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.prioritiesPublisher(forNeighbourhood: neighbourhoodID,
                                                                        inPoliceForce: policeForceID),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.priorities(neighbourhoodID: neighbourhoodID,
                                                                             policeForceID: policeForceID).url)
    }

    func testNeighbourhoodPolicingTeamAtCoordinatePublisherReturnsNeighbourhoodPolicingTeam() throws {
        let coordinate = Coordinate.mock
        let expectedResult = NeighbourhoodPolicingTeam.mock
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.neighbourhoodPolicingTeamPublisher(atCoordinate: coordinate),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.locateNeighbourhood(coordinate: coordinate).url)
    }

}
#endif
