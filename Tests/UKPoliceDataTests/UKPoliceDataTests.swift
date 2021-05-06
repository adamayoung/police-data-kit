@testable import UKPoliceData
import XCTest

final class UKPoliceDataAPITests: XCTestCase {

    var policeDataAPI: UKPoliceDataAPI!

    override func setUp() {
        super.setUp()

        policeDataAPI = UKPoliceDataAPI()
    }

    override func tearDown() {
        policeDataAPI = nil

        super.tearDown()
    }

    func testExists() {
        XCTAssertNotNil(policeDataAPI)
    }

}
