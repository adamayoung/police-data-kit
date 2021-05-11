@testable import UKPoliceData
import XCTest

#if canImport(Combine)
import Combine
#endif

final class UKNeighbourhoodServiceTests: XCTestCase {

    #if canImport(Combine)
    var cancellables: Set<AnyCancellable> = []
    #endif
    var service: UKNeighbourhoodService!
    var apiClient: MockAPIClient!

    override func setUp() {
        super.setUp()

        apiClient = MockAPIClient()
        service = UKNeighbourhoodService(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient.reset()
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

    func testFetchPolicingTeamReturnsNeighbourhoodPolicingTeam() {
        let latitude = 51.500617
        let longitude = -0.124629
        let expectedResult = NeighbourhoodPolicingTeam.mock
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchPolicingTeam(forLatitude: latitude, longitude: longitude) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.locateNeighbourhood(latitude: latitude,
                                                                                      longitude: longitude).url)
    }

    func testFetchPolicingTeamWithCoordinateReturnsNeighbourhoodPolicingTeam() {
        let coordinate = Coordinate(latitude: 51.500617, longitude: -0.124629)
        let expectedResult = NeighbourhoodPolicingTeam.mock
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchPolicingTeam(forCoordinate: coordinate) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath,
                       NeighbourhoodsEndpoint.locateNeighbourhood(latitude: coordinate.latitude,
                                                                  longitude: coordinate.longitude).url)
    }

}

#if canImport(Combine)
extension UKNeighbourhoodServiceTests {

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

    func testPolicingTeamPublisherReturnsNeighbourhoodPolicingTeam() throws {
        let latitude = 51.500617
        let longitude = -0.124629
        let expectedResult = NeighbourhoodPolicingTeam.mock
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.policingTeamPublisher(forLatitude: latitude, longitude: longitude),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, NeighbourhoodsEndpoint.locateNeighbourhood(latitude: latitude,
                                                                                      longitude: longitude).url)
    }

    func testPolicingTeamPublisherWithCoordinateReturnsNeighbourhoodPolicingTeam() throws {
        let coordinate = Coordinate(latitude: 51.500617, longitude: -0.124629)
        let expectedResult = NeighbourhoodPolicingTeam.mock
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.policingTeamPublisher(forCoordinate: coordinate),
                                 storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath,
                       NeighbourhoodsEndpoint.locateNeighbourhood(latitude: coordinate.latitude,
                                                                  longitude: coordinate.longitude).url)
    }

}
#endif
