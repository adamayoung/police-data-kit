@testable import PoliceDataKit
import XCTest

final class CrimeTests: XCTestCase {

    func testDecodeReturnsCrime() throws {
        let result = try JSONDecoder.policeDataAPI.decode(Crime.self, fromResource: "crime")

        XCTAssertEqual(result, .mock)
    }

}
