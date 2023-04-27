@testable import PoliceDataKit
import XCTest

final class AvailabilityServiceTests: XCTestCase {

    var availabilityService: AvailabilityService!
    var availabilityRepository: MockAvailabilityRepository!

    override func setUp() {
        super.setUp()
        availabilityRepository = MockAvailabilityRepository()
        availabilityService = AvailabilityService(availabilityRepository: availabilityRepository)
    }

    override func tearDown() {
        availabilityRepository = nil
        availabilityService = nil
        super.tearDown()
    }

    func testAvailableDataSetsReturnsAvailableDataSets() async throws {
        let expectedDataSets = [
            DataSet(
                date: Date(),
                stopAndSearch: ["police-force-1", "police-force-2"]
            )
        ]
        availabilityRepository.availableDataSetsResult = .success(expectedDataSets)

        let dataSets = try await availabilityService.availableDataSets()

        XCTAssertEqual(dataSets, expectedDataSets)
    }

}
