@testable import PoliceAPIData
import XCTest

final class StopAndSearchTypeDataModelTests: XCTestCase {

    func testPersonSearch() {
        let result = StopAndSearchTypeDataModel(rawValue: "Person search")

        XCTAssertEqual(result, .personSearch)
    }

    func testVehicleSearch() {
        let result = StopAndSearchTypeDataModel(rawValue: "Vehicle search")

        XCTAssertEqual(result, .vehicleSearch)
    }

    func testPersonAndVehicleSearch() {
        let result = StopAndSearchTypeDataModel(rawValue: "Person and Vehicle search")

        XCTAssertEqual(result, .personAndVehicleSearch)
    }

    func testDescriptionWhenPersonSearchReturnDescription() {
        let expectedResult = "Person search"

        let result = StopAndSearchTypeDataModel.personSearch.description

        XCTAssertEqual(result, expectedResult)
    }

    func testDescriptionWhenVehicleSearchReturnDescription() {
        let expectedResult = "Vehicle search"

        let result = StopAndSearchTypeDataModel.vehicleSearch.description

        XCTAssertEqual(result, expectedResult)
    }

    func testDescriptionWhenPersonAndVehicleSearchReturnDescription() {
        let expectedResult = "Person and Vehicle search"

        let result = StopAndSearchTypeDataModel.personAndVehicleSearch.description

        XCTAssertEqual(result, expectedResult)
    }

}
