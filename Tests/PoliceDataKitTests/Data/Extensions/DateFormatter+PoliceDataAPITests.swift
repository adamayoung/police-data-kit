@testable import PoliceDataKit
import XCTest

final class DateFormatterPoliceDataAPITests: XCTestCase {

    func testDateTimeFormatterReturnsDate() {
        let dateString = "2021-05-24T10:22:45"
        let expectedResult = "2021-05-24 10:22:45 +0000"
        let dateFormatter = DateFormatter.dateTime

        let result = dateFormatter.date(from: dateString)?.description

        XCTAssertEqual(result, expectedResult)
    }

    func testDateTimeFormatterWhenInvalidDateFormatReturnsNil() {
        let dateString = "2021-05-24"
        let dateFormatter = DateFormatter.dateTime

        let result = dateFormatter.date(from: dateString)

        XCTAssertNil(result)
    }

    func testDateTimeWithTimeZoneOffsetFormatterWhenUTCReturnsDate() {
        let dateString = "2020-01-31T12:45:12+00:00"
        let expectedResult = "2020-01-31 12:45:12 +0000"
        let dateFormatter = DateFormatter.dateTimeWithTimeZoneOffset

        let result = dateFormatter.date(from: dateString)?.description

        XCTAssertEqual(result, expectedResult)
    }

    func testDateTimeWithTimeZoneOffsetFormatterWhenMinusFiveHoursReturnsDate() {
        let dateString = "2019-09-15T21:01:58-05:00"
        let expectedResult = "2019-09-16 02:01:58 +0000"
        let dateFormatter = DateFormatter.dateTimeWithTimeZoneOffset

        let result = dateFormatter.date(from: dateString)?.description

        XCTAssertEqual(result, expectedResult)
    }

    func testDateTimeWithTimeZoneOffsetFormatterWhenInvalidDateFormatReturnsNil() {
        let dateString = "2020-01-31"
        let dateFormatter = DateFormatter.dateTimeWithTimeZoneOffset

        let result = dateFormatter.date(from: dateString)

        XCTAssertNil(result)
    }

    func testYearMonthFormatterReturnsDate() {
        let dateString = "2021-02"
        let expectedResult = "2021-02-01 00:00:00 +0000"
        let dateFormatter = DateFormatter.yearMonth

        let result = dateFormatter.date(from: dateString)?.description

        XCTAssertEqual(result, expectedResult)
    }

    func testYearMonthFormatterWhenInvalidDateFormatReturnsDate() {
        let dateString = "2021-02-01"
        let dateFormatter = DateFormatter.yearMonth

        let result = dateFormatter.date(from: dateString)

        XCTAssertNil(result)
    }

}
