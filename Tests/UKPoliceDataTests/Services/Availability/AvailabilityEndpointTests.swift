@testable import UKPoliceData
import XCTest

class AvailabilityEndpointTests: XCTestCase {

    func testDataSetsEndpointReturnsURL() {
        let expectedURL = URL(string: "/crimes-street-dates")!

        let url = AvailabilityEndpoint.dataSets.url

        XCTAssertEqual(url, expectedURL)
    }

}
