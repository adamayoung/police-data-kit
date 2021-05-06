@testable import UKPoliceData
import XCTest

final class LinkTests: XCTestCase {

    func testDecodeReturnsLink() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Link.self, fromResource: "link", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
