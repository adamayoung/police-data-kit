@testable import PoliceDataKit
import XCTest

final class NeighbourhoodTests: XCTestCase {

    func testDecodeReturnsNeighbourhood() throws {
        let result = try JSONDecoder.policeDataAPI.decode(Neighbourhood.self, fromResource: "neighbourhood")

        XCTAssertEqual(result, .mock)
    }

    func testPopulationReturnsPopulation() throws {
        let expectedResult = Neighbourhood.mock.population

        let result = try JSONDecoder.policeDataAPI.decode(Neighbourhood.self, fromResource: "neighbourhood")

        XCTAssertEqual(result.population, expectedResult)
    }

}
