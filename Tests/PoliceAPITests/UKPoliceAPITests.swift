@testable import PoliceAPI
import XCTest

final class UKPoliceAPITests: XCTestCase {

    var api: UKPoliceAPI!

    override func setUp() {
        super.setUp()

        api = UKPoliceAPI()
    }

    override func tearDown() {
        api = nil

        super.tearDown()
    }

    func testExists() {
        XCTAssertNotNil(api)
    }

}
