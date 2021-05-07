@testable import UKPoliceData
import XCTest

final class PoliceDataErrorTests: XCTestCase {

    func testNetworkReturnsDescription() {
        let expectedResult = "Some network error message"
        let networkError = MockError(message: expectedResult)
        let error = PoliceDataError.network(networkError)

        let result = error.localizedDescription

        XCTAssertEqual(result, expectedResult)
    }

    func testNotFoundReturnsDescription() {
        let error = PoliceDataError.notFound
        let expectedResult = "Not Found"

        let result = error.localizedDescription

        XCTAssertEqual(result, expectedResult)
    }

    func testUnknownReturnsDescription() {
        let error = PoliceDataError.unknown
        let expectedResult = "Unknown Error"

        let result = error.localizedDescription

        XCTAssertEqual(result, expectedResult)
    }

    func testDecodeReturnsDescription() {
        let decodeError = MockError(message: "Some decode error message")
        let error = PoliceDataError.decode(decodeError)
        let expectedResult = "Data Decode Error"

        let result = error.localizedDescription

        XCTAssertEqual(result, expectedResult)
    }

}
