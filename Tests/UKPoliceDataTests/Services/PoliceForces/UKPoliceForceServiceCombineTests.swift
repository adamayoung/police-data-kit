#if canImport(Combine)
import Combine
@testable import UKPoliceData
import XCTest

class UKPoliceForceServiceCombineTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []
    var service: UKPoliceForceService!
    var apiClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        apiClient = MockAPIClient()
        service = UKPoliceForceService(apiClient: apiClient)
    }

    override func tearDown() {
        apiClient = nil
        service = nil
        super.tearDown()
    }

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
