@testable import PoliceDataKit
import XCTest

final class AvailabilityEndpointTests: XCTestCase {

    func testDataSetsEndpointReturnsURL() throws {
        let expectedPath = try XCTUnwrap(URL(string: "/crimes-street-dates"))

        let path = AvailabilityEndpoint.dataSets.path

        XCTAssertEqual(path, expectedPath)
    }

}
