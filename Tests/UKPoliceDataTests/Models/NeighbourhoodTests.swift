@testable import UKPoliceData
import XCTest

class NeighbourhoodTests: XCTestCase {

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

    func testNameDoesNotContainHTMLEntities() throws {
        let expectedResult = Neighbourhood.mockWithAmpersandInName.name

        let result = try JSONDecoder.policeDataAPI
            .decode(Neighbourhood.self, fromResource: "neighbourhood-html-in-name",
                    withExtension: "json")
            .name

        XCTAssertEqual(result, expectedResult)
    }

    func testDescriptionDoesNotContainHTMLEntities() throws {
        let expectedResult = Neighbourhood.mockWithAmpersandInName.description

        let result = try JSONDecoder.policeDataAPI
            .decode(Neighbourhood.self, fromResource: "neighbourhood-html-in-name",
                    withExtension: "json")
            .description

        XCTAssertEqual(result, expectedResult)
    }

}
