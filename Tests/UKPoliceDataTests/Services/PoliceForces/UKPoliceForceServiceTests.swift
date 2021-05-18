@testable import UKPoliceData
import XCTest

#if canImport(Combine)
import Combine
#endif

class UKPoliceForceServiceTests: XCTestCase {

    #if canImport(Combine)
    var cancellables: Set<AnyCancellable> = []
    #endif
    var service: UKPoliceForceService!
    var apiClient: MockAPIClient!

    override func setUp() {
        super.setUp()

        apiClient = MockAPIClient()
        service = UKPoliceForceService(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient.reset()
        apiClient = nil
        service = nil

        super.tearDown()
    }

    func testFetchAllReturnsPoliceForceReferences() {
        let expectedResult = PoliceForceReference.mocks
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchAll { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.list.url)
    }

    func testFetchDetailsReturnsPoliceForce() {
        let expectedResult = PoliceForce.mock
        let id = expectedResult.id
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchDetails(forPoliceForce: id) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.details(id: id).url)
    }

    func testFetchSeniorOfficersReturnsPoliceOfficers() {
        let expectedResult = PoliceOfficer.mocks
        let id = "leicestershire"
        apiClient.response = expectedResult

        let expectation = XCTestExpectation(description: "await")
        service.fetchSeniorOfficers(forPoliceForce: id) { result in
            XCTAssertEqual(try? result.get(), expectedResult)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)

        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.seniorOfficers(policeForceID: id).url)
    }

}

#if canImport(Combine)
extension UKPoliceForceServiceTests {

    func testPoliceForcesPublisherReturnsPoliceForceReferences() throws {
        let expectedResult = PoliceForceReference.mocks
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.policeForcesPublisher(), storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.list.url)
    }

    func testDetailsPublisherReturnsPoliceForce() throws {
        let expectedResult = PoliceForce.mock
        let id = expectedResult.id
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.detailsPublisher(forPoliceForce: id), storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.details(id: id).url)
    }

    func testSeniorOfficersPublisherReturnsPoliceOfficers() throws {
        let expectedResult = PoliceOfficer.mocks
        let id = "leicestershire"
        apiClient.response = expectedResult

        let result = try waitFor(publisher: service.seniorOfficersPublisher(forPoliceForce: id), storeIn: &cancellables)

        XCTAssertEqual(result, expectedResult)
        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.seniorOfficers(policeForceID: id).url)
    }

}
#endif
