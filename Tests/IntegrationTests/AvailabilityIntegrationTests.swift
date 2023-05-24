import PoliceDataKit
import XCTest

final class AvailabilityIntegrationTests: XCTestCase {

    var availabilityService: AvailabilityService!

    override func setUp() {
        super.setUp()
        availabilityService = AvailabilityService()
    }

    override func tearDown() {
        availabilityService = nil
        super.tearDown()
    }

    func testAvailableDataSets() async throws {
        let dataSets = try await availabilityService.availableDataSets()

        XCTAssertGreaterThan(dataSets.count, 0)
    }

}
