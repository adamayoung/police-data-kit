@testable import PoliceDataKit
import XCTest

final class GenderDataModelTests: XCTestCase {

    func testMale() {
        let result = GenderDataModel(rawValue: "Male")

        XCTAssertEqual(result, .male)
    }

    func testFemale() {
        let result = GenderDataModel(rawValue: "Female")

        XCTAssertEqual(result, .female)
    }

    func testDescriptionWhenMaleReturnDescription() {
        let expectedResult = "Male"

        let result = GenderDataModel.male.rawValue

        XCTAssertEqual(result, expectedResult)
    }

    func testDescriptionWhenVehicleSearchReturnDescription() {
        let expectedResult = "Female"

        let result = GenderDataModel.female.rawValue

        XCTAssertEqual(result, expectedResult)
    }

}
