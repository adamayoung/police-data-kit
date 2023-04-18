@testable import PoliceAPI
import XCTest

final class AvailabilityEndpointTests: XCTestCase {

    func testDataSetsEndpointReturnsURL() {
        let expectedPath = URL(string: "/crimes-street-dates")!

        let path = AvailabilityEndpoint.dataSets.path

        XCTAssertEqual(path, expectedPath)
    }

}
