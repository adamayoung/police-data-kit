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

    func testDecodeWithEmptyPoliceForceWebsiteURL() throws {
        let result = try JSONDecoder.policeDataAPI.decode(
            Neighbourhood.self,
            fromResource: "neighbourhood-empty-force-url"
        )

        XCTAssertNil(result.policeForceWebsiteURL)
    }

    func testDecodedWithHTMLInName() throws {
        let expectedResult = "Leake & Keyworth"

        let result = try JSONDecoder.policeDataAPI.decode(
            Neighbourhood.self,
            fromResource: "neighbourhood-html-in-name"
        )

        XCTAssertEqual(result.name, expectedResult)
    }

}
