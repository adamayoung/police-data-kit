@testable import PoliceAPI
import XCTest

final class NeighbourhoodDataModelTests: XCTestCase {

    func testDecodeReturnsNeighbourhood() throws {
        let result = try JSONDecoder.policeDataAPI.decode(NeighbourhoodDataModel.self, fromResource: "neighbourhood")

        XCTAssertEqual(result, .mock)
    }

    func testPopulationReturnsPopulation() throws {
        let expectedResult = NeighbourhoodDataModel.mock.population

        let result = try JSONDecoder.policeDataAPI.decode(NeighbourhoodDataModel.self, fromResource: "neighbourhood")

        XCTAssertEqual(result.population, expectedResult)
    }

}
