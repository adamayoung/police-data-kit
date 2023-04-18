@testable import PoliceAPI
import XCTest

final class UKPoliceForceServiceTests: XCTestCase {

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

    func testPoliceForcesReturnsPoliceForceReferences() async throws {
        let expectedResult = PoliceForceReference.mocks
        apiClient.response = expectedResult

        let result = try await service.policeForces()

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.list.path)
    }

    func testPoliceForceReturnsPoliceForce() async throws {
        let expectedResult = PoliceForce.mock
        let id = expectedResult.id
        apiClient.response = expectedResult

        let result = try await service.policeForce(withID: id)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.details(id: id).path)
    }

    func testFetchSeniorOfficersReturnsPoliceOfficers() async throws {
        let expectedResult = PoliceOfficer.mocks
        let id = "leicestershire"
        apiClient.response = expectedResult

        let result = try await service.seniorOfficers(inPoliceForce: id)

        XCTAssertEqual(result, expectedResult)

        XCTAssertEqual(apiClient.lastPath, PoliceForcesEndpoint.seniorOfficers(policeForceID: id).path)
    }

}
