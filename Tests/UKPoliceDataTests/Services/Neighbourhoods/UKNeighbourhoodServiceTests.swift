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

}
#endif
