//
//  JSONDecoderDateDecodingStrategy+PoliceDataAPITests.swift
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

@testable import PoliceDataKit
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
        let data = Data("""
            {
                "date": "2021-05-24T11:28:00"
            }
        """.utf8)
        let expectedResult = Date(timeIntervalSince1970: 1_621_855_680)

        let container = try decoder.decode(Container.self, from: data)
        let result = container.date

        XCTAssertEqual(result, expectedResult)
    }

    func testDecodingDateTimeWithTimeZoneOffsetDateReturnsDate() throws {
        let data = Data("""
            {
                "date": "2021-05-24T11:28:00-07:00"
            }
        """.utf8)
        let expectedResult = Date(timeIntervalSince1970: 1_621_880_880)

        let container = try decoder.decode(Container.self, from: data)
        let result = container.date

        XCTAssertEqual(result, expectedResult)
    }

    func testDecodingYearMonthDateReturnsDate() throws {
        let data = Data("""
            {
                "date": "2021-05"
            }
        """.utf8)
        let expectedResult = Date(timeIntervalSince1970: 1_619_827_200)

        let container = try decoder.decode(Container.self, from: data)
        let result = container.date

        XCTAssertEqual(result, expectedResult)
    }

    func testDecodingWhenInvalidDateThrowsDecodingError() throws {
        let data = Data("""
            {
                "date": "11111"
            }
        """.utf8)

        XCTAssertThrowsError(try decoder.decode(Container.self, from: data))
    }

}

private struct Container: Decodable, Equatable {

    let date: Date

}
