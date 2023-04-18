@testable import PoliceAPI
import XCTest

final class StopAndSearchTypeTests: XCTestCase {

    func testPersonSearch() {
        let result = StopAndSearchType(rawValue: "Person search")

        XCTAssertEqual(result, .personSearch)
    }

    func testVehicleSearch() {
        let result = StopAndSearchType(rawValue: "Vehicle search")

        XCTAssertEqual(result, .vehicleSearch)
    }

    func testPersonAndVehicleSearch() {
        let result = StopAndSearchType(rawValue: "Person and Vehicle search")

        XCTAssertEqual(result, .personAndVehicleSearch)
    }

    func testDescriptionWhenPersonSearchReturnDescription() {
        let expectedResult = "Person search"

        let result = StopAndSearchType.personSearch.description

        XCTAssertEqual(result, expectedResult)
    }

    func testDescriptionWhenVehicleSearchReturnDescription() {
        let expectedResult = "Vehicle search"

        let result = StopAndSearchType.vehicleSearch.description

        XCTAssertEqual(result, expectedResult)
    }

    func testDescriptionWhenPersonAndVehicleSearchReturnDescription() {
        let expectedResult = "Person and Vehicle search"

        let result = StopAndSearchType.personAndVehicleSearch.description

        XCTAssertEqual(result, expectedResult)
    }

}
