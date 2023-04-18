@testable import PoliceAPI
import XCTest

final class NeighbourhoodTests: XCTestCase {

    func testDecodeReturnsNeighbourhood() throws {
        let result = try JSONDecoder.policeDataAPI.decode(Neighbourhood.self, fromResource: "neighbourhood")

        XCTAssertEqual(result, .mock)
    }

    func testPopulationReturnsPopulation() throws {
        let expectedResult = Neighbourhood.mock.population

        let result = try JSONDecoder.policeDataAPI.decode(Neighbourhood.self, fromResource: "neighbourhood").population

        XCTAssertEqual(result, expectedResult)
    }

    func testPopulationWhenInvalidNumberReturnsZero() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Neighbourhood.self, fromResource: "neighbourhood-invalid-population").population

        XCTAssertEqual(result, 0)
    }

    func testNameDoesNotContainHTMLEntities() throws {
        let expectedResult = Neighbourhood.mockWithAmpersandInName.name

        let result = try JSONDecoder.policeDataAPI
            .decode(Neighbourhood.self, fromResource: "neighbourhood-html-in-name").name

        XCTAssertEqual(result, expectedResult)
    }

    func testDescriptionDoesNotContainHTMLEntities() throws {
        let expectedResult = Neighbourhood.mockWithAmpersandInName.description

        let result = try JSONDecoder.policeDataAPI
            .decode(Neighbourhood.self, fromResource: "neighbourhood-html-in-name").description

        XCTAssertEqual(result, expectedResult)
    }

}
