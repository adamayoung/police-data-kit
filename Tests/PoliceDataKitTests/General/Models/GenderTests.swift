@testable import PoliceDataKit
import XCTest

final class GenderTests: XCTestCase {

    func testMale() {
        let result = Gender(rawValue: "Male")

        XCTAssertEqual(result, .male)
    }

    func testFemale() {
        let result = Gender(rawValue: "Female")

        XCTAssertEqual(result, .female)
    }

    func testDescriptionWhenMaleReturnDescription() {
        let expectedResult = "Male"

        let result = Gender.male.rawValue

        XCTAssertEqual(result, expectedResult)
    }

    func testDescriptionWhenVehicleSearchReturnDescription() {
        let expectedResult = "Female"

        let result = Gender.female.rawValue

        XCTAssertEqual(result, expectedResult)
    }

}
