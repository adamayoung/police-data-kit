@testable import UKPoliceData
import XCTest

final class JSONDecoderDateDecodingStrategyPoliceDataAPITestsTests: XCTestCase {

    var decoder: JSONDecoder!

    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .policeDataAPI
    }

    override func tearDown() {
        decoder = nil
        super.tearDown()
    }

    func testDecodingDateTimeDateReturnsDate() throws {
        let data = """
            {
                "date": "2021-05-24T11:28:00"
            }
        """.data(using: .utf8)!
        let expectedResult = Date(timeIntervalSince1970: 1621855680)

        let container = try decoder.decode(Container.self, from: data)
        let result = container.date

        XCTAssertEqual(result, expectedResult)
    }

    func testDecodingDateTimeWithTimeZoneOffsetDateReturnsDate() throws {
        let data = """
            {
                "date": "2021-05-24T11:28:00-07:00"
            }
        """.data(using: .utf8)!
        let expectedResult = Date(timeIntervalSince1970: 1621880880)

        let container = try decoder.decode(Container.self, from: data)
        let result = container.date

        XCTAssertEqual(result, expectedResult)
    }

    func testDecodingYearMonthDateReturnsDate() throws {
        let data = """
            {
                "date": "2021-05"
            }
        """.data(using: .utf8)!
        let expectedResult = Date(timeIntervalSince1970: 1619827200)

        let container = try decoder.decode(Container.self, from: data)
        let result = container.date

        XCTAssertEqual(result, expectedResult)
    }

    func testDecodingWhenInvalidDateThrowsDecodingError() {
        let data = """
            {
                "date": "11111"
            }
        """.data(using: .utf8)!

        XCTAssertThrowsError(try decoder.decode(Container.self, from: data))
    }

}

private struct Container: Decodable, Equatable {

    let date: Date

}
