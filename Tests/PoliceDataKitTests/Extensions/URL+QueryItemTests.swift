import CoreLocation
@testable import PoliceDataKit
import XCTest

final class URLQueryItemTests: XCTestCase {

    func testAppendingQueryItemWithCustomStringConvertibleWhenURLContainsNoQueryItemsReturnsURL() {
        let baseURL = URL(string: "https://some.domain.com")
        let queryItemName = "name"
        let value: CustomStringConvertible = "dave"
        let expectedResult = URL(string: "https://some.domain.com?\(queryItemName)=\(value)")

        let result = baseURL?.appendingQueryItem(name: queryItemName, value: value)

        XCTAssertEqual(result, expectedResult)
    }

    func testAppendingQueryItemWithCustomStringConvertibleWhenURLContainsQueryItemsReturnsURL() {
        let baseURL = URL(string: "https://some.domain.com?id=123")
        let queryItemName = "sort"
        let value: CustomStringConvertible = "asc"
        let expectedResult = URL(string: "https://some.domain.com?id=123&\(queryItemName)=\(value)")

        let result = baseURL?.appendingQueryItem(name: queryItemName, value: value)

        XCTAssertEqual(result, expectedResult)
    }

    func testAppendingQueryItemWithDateWhenURLContainsNoQueryItemsAndNoDateFormatterReturnsURLWithYearMonthDate() {
        let baseURL = URL(string: "https://some.domain.com")
        let queryItemName = "date"
        let date = Date(timeIntervalSince1970: 1621850198) // 2021-05-24 09:56:38 +0000
        let expectedResult = URL(string: "https://some.domain.com?\(queryItemName)=2021-05")

        let result = baseURL?.appendingQueryItem(name: queryItemName, date: date)

        XCTAssertEqual(result, expectedResult)
    }

    func testAppendingQueryItemWithDateWhenURLContainsQueryItemsAndNoDateFormatterReturnsURLWithYearMonthDate() {
        let baseURL = URL(string: "https://some.domain.com?id=987")
        let queryItemName = "date"
        let date = Date(timeIntervalSince1970: 1621850198) // 2021-05-24 09:56:38 +0000
        let expectedResult = URL(string: "https://some.domain.com?id=987&\(queryItemName)=2021-05")

        let result = baseURL?.appendingQueryItem(name: queryItemName, date: date)

        XCTAssertEqual(result, expectedResult)
    }

    func testAppendingQueryItemWithDateWhenURLContainsNoQueryItemsAndWithDateFormatterReturnsURLWithFormattedDate() {
        let baseURL = URL(string: "https://some.domain.com")
        let queryItemName = "date"
        let date = Date(timeIntervalSince1970: 1621850198) // 2021-05-24 09:56:38 +0000
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let expectedResult = URL(string: "https://some.domain.com?\(queryItemName)=2021-05-24")

        let result = baseURL?.appendingQueryItem(name: queryItemName, date: date, formatter: dateFormatter)

        XCTAssertEqual(result, expectedResult)
    }

    func testAppendingQueryItemWithDateWhenURLContainsNoQueryItemsAndDateIsNilReturnsURL() {
        let baseURL = URL(string: "https://some.domain.com")
        let queryItemName = "date"

        let expectedResult = baseURL

        let result = baseURL?.appendingQueryItem(name: queryItemName, date: nil)

        XCTAssertEqual(result, expectedResult)
    }

    func testAppendingQueryItemWithDateWhenURLContainsQueryItemsAndDateIsNilReturnsURL() {
        let baseURL = URL(string: "https://some.domain.com?id=654")
        let queryItemName = "date"

        let expectedResult = baseURL

        let result = baseURL?.appendingQueryItem(name: queryItemName, date: nil)

        XCTAssertEqual(result, expectedResult)
    }

    func testAppendingQueryItemWithCoordinateWhenURLContainsNoQueryItemsReturnsURLWithCoordinate() {
        let baseURL = URL(string: "https://some.domain.com")
        let queryItemName = "coord"
        let coordinate = CLLocationCoordinate2D(latitude: 52.6389, longitude: -1.13619)
        let expectedResult = URL(
            string: "https://some.domain.com?\(queryItemName)=\(coordinate.latitude),\(coordinate.longitude)"
        )

        let result = baseURL?.appendingQueryItem(name: queryItemName, coordinate: coordinate)

        XCTAssertEqual(result, expectedResult)
    }

    func testAppendingQueryItemWithCoordinateWhenURLContainsQueryItemsReturnsURLWithCoordinate() {
        let baseURL = URL(string: "https://some.domain.com?id=456")
        let queryItemName = "coord"
        let coordinate = CLLocationCoordinate2D(latitude: 52.6389, longitude: -1.13619)
        let expectedResult = URL(
            string: "https://some.domain.com?id=456&\(queryItemName)=\(coordinate.latitude),\(coordinate.longitude)"
        )

        let result = baseURL?.appendingQueryItem(name: queryItemName, coordinate: coordinate)

        XCTAssertEqual(result, expectedResult)
    }

    func testAppendingQueryItemWithCoordinatesWhenURLContainsNoQueryItemsReturnsURLWithCoordinates() {
        let baseURL = URL(string: "https://some.domain.com")
        let queryItemName = "poly"
        let coordinates = CLLocationCoordinate2D.mocks
        let poly = coordinates.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let expectedResult = URL(
            string: "https://some.domain.com?\(queryItemName)=\(poly)"
        )

        let result = baseURL?.appendingQueryItem(name: queryItemName, coordinates: coordinates)

        XCTAssertEqual(result, expectedResult)
    }

    func testAppendingQueryItemWithCoordinatesWhenURLContainsQueryItemsReturnsURLWithCoordinates() {
        let baseURL = URL(string: "https://some.domain.com?id=789")
        let queryItemName = "poly"
        let coordinates = CLLocationCoordinate2D.mocks
        let poly = coordinates.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let expectedResult = URL(
            string: "https://some.domain.com?id=789&\(queryItemName)=\(poly)"
        )

        let result = baseURL?.appendingQueryItem(name: queryItemName, coordinates: coordinates)

        XCTAssertEqual(result, expectedResult)
    }

}
