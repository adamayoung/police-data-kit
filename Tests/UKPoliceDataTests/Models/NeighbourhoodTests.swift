@testable import UKPoliceData
import XCTest

final class NeighbourhoodTests: XCTestCase {

    func testDecodeReturnsNeighbourhood() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Neighbourhood.self, fromResource: "neighbourhood", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

    func testPopulationReturnsPopulation() throws {
        let expectedResult = Neighbourhood.mock.population

        let result = try JSONDecoder.policeDataAPI
            .decode(Neighbourhood.self, fromResource: "neighbourhood", withExtension: "json").population

        XCTAssertEqual(result, expectedResult)
    }

    func testPopulationWhenInvalidNumberReturnsZero() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Neighbourhood.self, fromResource: "neighbourhood-invalid-population",
                    withExtension: "json")
            .population

        XCTAssertEqual(result, 0)
    }

}
