//
//  URL+QueryItemTests.swift
//  PoliceDataKit
//
//  Copyright © 2024 Adam Young.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an AS IS BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import CoreLocation
import Foundation
@testable import PoliceDataKit
import Testing

@Suite("URL query item")
struct URLQueryItemTests {

    @Test("appendingQueryItem with CustomStringConvertible when URL contains no query items returns URL")
    func appendingQueryItemWithCustomStringConvertibleWhenURLContainsNoQueryItemsReturnsURL() {
        let baseURL = URL(string: "https://some.domain.com")
        let queryItemName = "name"
        let value: CustomStringConvertible = "dave"
        let expectedResult = URL(string: "https://some.domain.com?\(queryItemName)=\(value)")

        let result = baseURL?.appendingQueryItem(name: queryItemName, value: value)

        #expect(result == expectedResult)
    }

    @Test("appendingQueryItem with CustomStringConvertible when URL contains query items returns URL")
    func appendingQueryItemWithCustomStringConvertibleWhenURLContainsQueryItemsReturnsURL() {
        let baseURL = URL(string: "https://some.domain.com?id=123")
        let queryItemName = "sort"
        let value: CustomStringConvertible = "asc"
        let expectedResult = URL(string: "https://some.domain.com?id=123&\(queryItemName)=\(value)")

        let result = baseURL?.appendingQueryItem(name: queryItemName, value: value)

        #expect(result == expectedResult)
    }

    @Test("appendingQueryItem with Date when no query items and no date formatter returns URL with year-month date")
    func appendingQueryItemWithDateWhenURLContainsNoQueryItemsAndNoDateFormatterReturnsURLWithYearMonthDate() {
        let baseURL = URL(string: "https://some.domain.com")
        let queryItemName = "date"
        let date = Date(timeIntervalSince1970: 1_621_850_198) // 2021-05-24 09:56:38 +0000
        let expectedResult = URL(string: "https://some.domain.com?\(queryItemName)=2021-05")

        let result = baseURL?.appendingQueryItem(name: queryItemName, date: date)

        #expect(result == expectedResult)
    }

    @Test("appendingQueryItem with Date when query items exist and no formatter returns URL with year-month date")
    func appendingQueryItemWithDateWhenURLContainsQueryItemsAndNoDateFormatterReturnsURLWithYearMonthDate() {
        let baseURL = URL(string: "https://some.domain.com?id=987")
        let queryItemName = "date"
        let date = Date(timeIntervalSince1970: 1_621_850_198) // 2021-05-24 09:56:38 +0000
        let expectedResult = URL(string: "https://some.domain.com?id=987&\(queryItemName)=2021-05")

        let result = baseURL?.appendingQueryItem(name: queryItemName, date: date)

        #expect(result == expectedResult)
    }

    @Test("appendingQueryItem with Date when no query items and with date formatter returns URL with formatted date")
    func appendingQueryItemWithDateWhenURLContainsNoQueryItemsAndWithDateFormatterReturnsURLWithFormattedDate() {
        let baseURL = URL(string: "https://some.domain.com")
        let queryItemName = "date"
        let date = Date(timeIntervalSince1970: 1_621_850_198) // 2021-05-24 09:56:38 +0000
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let expectedResult = URL(string: "https://some.domain.com?\(queryItemName)=2021-05-24")

        let result = baseURL?.appendingQueryItem(name: queryItemName, date: date, formatter: dateFormatter)

        #expect(result == expectedResult)
    }

    @Test("appendingQueryItem with Date when URL contains no query items and date is nil returns URL")
    func appendingQueryItemWithDateWhenURLContainsNoQueryItemsAndDateIsNilReturnsURL() {
        let baseURL = URL(string: "https://some.domain.com")
        let queryItemName = "date"

        let expectedResult = baseURL

        let result = baseURL?.appendingQueryItem(name: queryItemName, date: nil)

        #expect(result == expectedResult)
    }

    @Test("appendingQueryItem with Date when URL contains query items and date is nil returns URL")
    func appendingQueryItemWithDateWhenURLContainsQueryItemsAndDateIsNilReturnsURL() {
        let baseURL = URL(string: "https://some.domain.com?id=654")
        let queryItemName = "date"

        let expectedResult = baseURL

        let result = baseURL?.appendingQueryItem(name: queryItemName, date: nil)

        #expect(result == expectedResult)
    }

    @Test("appendingQueryItem with coordinate when URL contains no query items returns URL with coordinate")
    func appendingQueryItemWithCoordinateWhenURLContainsNoQueryItemsReturnsURLWithCoordinate() {
        let baseURL = URL(string: "https://some.domain.com")
        let queryItemName = "coord"
        let coordinate = CLLocationCoordinate2D(latitude: 52.6389, longitude: -1.13619)
        let expectedResult = URL(
            string: "https://some.domain.com?\(queryItemName)=\(coordinate.latitude),\(coordinate.longitude)"
        )

        let result = baseURL?.appendingQueryItem(name: queryItemName, coordinate: coordinate)

        #expect(result == expectedResult)
    }

    @Test("appendingQueryItem with coordinate when URL contains query items returns URL with coordinate")
    func appendingQueryItemWithCoordinateWhenURLContainsQueryItemsReturnsURLWithCoordinate() {
        let baseURL = URL(string: "https://some.domain.com?id=456")
        let queryItemName = "coord"
        let coordinate = CLLocationCoordinate2D(latitude: 52.6389, longitude: -1.13619)
        let expectedResult = URL(
            string: "https://some.domain.com?id=456&\(queryItemName)=\(coordinate.latitude),\(coordinate.longitude)"
        )

        let result = baseURL?.appendingQueryItem(name: queryItemName, coordinate: coordinate)

        #expect(result == expectedResult)
    }

    @Test("appendingQueryItem with coordinates when URL contains no query items returns URL with coordinates")
    func appendingQueryItemWithCoordinatesWhenURLContainsNoQueryItemsReturnsURLWithCoordinates() {
        let baseURL = URL(string: "https://some.domain.com")
        let queryItemName = "poly"
        let coordinates = CLLocationCoordinate2D.mocks
        let poly = coordinates.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let expectedResult = URL(
            string: "https://some.domain.com?\(queryItemName)=\(poly)"
        )

        let result = baseURL?.appendingQueryItem(name: queryItemName, coordinates: coordinates)

        #expect(result == expectedResult)
    }

    @Test("appendingQueryItem with coordinates when URL contains query items returns URL with coordinates")
    func appendingQueryItemWithCoordinatesWhenURLContainsQueryItemsReturnsURLWithCoordinates() {
        let baseURL = URL(string: "https://some.domain.com?id=789")
        let queryItemName = "poly"
        let coordinates = CLLocationCoordinate2D.mocks
        let poly = coordinates.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let expectedResult = URL(
            string: "https://some.domain.com?id=789&\(queryItemName)=\(poly)"
        )

        let result = baseURL?.appendingQueryItem(name: queryItemName, coordinates: coordinates)

        #expect(result == expectedResult)
    }

}
