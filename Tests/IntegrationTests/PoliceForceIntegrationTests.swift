import PoliceDataKit
import XCTest

final class PoliceForceIntegrationTests: XCTestCase {

    var policeForceService: PoliceForceService!

    override func setUp() {
        super.setUp()
        policeForceService = PoliceForceService()
    }

    override func tearDown() {
        policeForceService = nil
        super.tearDown()
    }

    func testPoliceForces() async throws {
        let policeForces = try await policeForceService.policeForces()

        XCTAssertGreaterThan(policeForces.count, 0)
    }

    func testPoliceForceWithCambridgeshireConstabulary() async throws {
        let policForceID = "cambridgeshire"

        let policeForce = try await policeForceService.policeForce(withID: policForceID)

        XCTAssertEqual(policeForce.id, policForceID)
    }

    func testPoliceForceWithSulfolkConstabulary() async throws {
        let policForceID = "suffolk"

        let policeForce = try await policeForceService.policeForce(withID: policForceID)

        XCTAssertEqual(policeForce.id, policForceID)
    }

    func testPoliceForceWithInvalidPoliceForce() async throws {
        let policForceID = "aaa"

        var policeForceError: PoliceForceError?
        do {
            _ = try await policeForceService.policeForce(withID: policForceID)
        } catch let error {
            policeForceError = error as? PoliceForceError
        }

        XCTAssertNotNil(policeForceError)
        XCTAssertEqual(policeForceError, .notFound)
    }

    func testSeniorOfficersForStaffordshirePolice() async throws {
        let policForceID = "staffordshire"

        let policeOfficers = try await policeForceService.seniorOfficers(inPoliceForce: policForceID)

        XCTAssertGreaterThan(policeOfficers.count, 0)
    }

    func testSeniorOfficersForNottinghamshirePolice() async throws {
        let policForceID = "nottinghamshire"

        let policeOfficers = try await policeForceService.seniorOfficers(inPoliceForce: policForceID)

        XCTAssertGreaterThan(policeOfficers.count, 0)
    }

    func testSeniorOfficersForInvalidPoliceForce() async throws {
        let policForceID = "bbb"

        var policeForceError: PoliceForceError?
        do {
            _ = try await policeForceService.seniorOfficers(inPoliceForce: policForceID)
        } catch let error {
            policeForceError = error as? PoliceForceError
        }

        XCTAssertNotNil(policeForceError)
        XCTAssertEqual(policeForceError, .notFound)
    }

}
