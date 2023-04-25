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

    func testPopulationWhenInvalidNumberReturnsZero() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodDataModel.self, fromResource: "neighbourhood-invalid-population")

        XCTAssertEqual(result.population, 0)
    }

    func testNameDoesNotContainHTMLEntities() throws {
        let expectedResult = NeighbourhoodDataModel.mockWithAmpersandInName.name

        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodDataModel.self, fromResource: "neighbourhood-html-in-name")

        XCTAssertEqual(result.name, expectedResult)
    }

    func testDescriptionDoesNotContainHTMLEntities() throws {
        let expectedResult = NeighbourhoodDataModel.mockWithAmpersandInName.description

        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodDataModel.self, fromResource: "neighbourhood-html-in-name")

        XCTAssertEqual(result.description, expectedResult)
    }

    func testPoliceForceWebsiteWhenEmpty() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodDataModel.self, fromResource: "neighbourhood-empty-force-url")

        XCTAssertNil(result.policeForceWebsite)
    }

    func testPoliceForceWebsiteWhenNull() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodDataModel.self, fromResource: "neighbourhood-null-force-url")

        XCTAssertNil(result.policeForceWebsite)
    }

}
