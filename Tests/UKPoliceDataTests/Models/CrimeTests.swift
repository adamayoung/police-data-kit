@testable import UKPoliceData
import XCTest

class CrimeTests: XCTestCase {

    func testDecodeReturnsCrime() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(Crime.self, fromResource: "crime", withExtension: "json")

        XCTAssertEqual(result, .mock)
    }

}
