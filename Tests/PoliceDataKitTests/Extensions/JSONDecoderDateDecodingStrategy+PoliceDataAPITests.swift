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

import Foundation
@testable import PoliceDataKit
import Testing

@Suite("JSONDecoder date decoding strategy PoliceDataAPI")
struct JSONDecoderDateDecodingStrategyPoliceDataAPITestsTests {

    let decoder: JSONDecoder

    init() {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .policeDataAPI
        self.decoder = decoder
    }

    @Test("decoding DateTime date returns date")
    func decodingDateTimeDateReturnsDate() throws {
        let data = Data("""
            {
                "date": "2021-05-24T11:28:00"
            }
        """.utf8)
        let expectedResult = Date(timeIntervalSince1970: 1_621_855_680)

        let container = try decoder.decode(Container.self, from: data)
        let result = container.date

        #expect(result == expectedResult)
    }

    @Test("decoding DateTime with timezone offset date returns date")
    func decodingDateTimeWithTimeZoneOffsetDateReturnsDate() throws {
        let data = Data("""
            {
                "date": "2021-05-24T11:28:00-07:00"
            }
        """.utf8)
        let expectedResult = Date(timeIntervalSince1970: 1_621_880_880)

        let container = try decoder.decode(Container.self, from: data)
        let result = container.date

        #expect(result == expectedResult)
    }

    @Test("decoding year-month date returns date")
    func decodingYearMonthDateReturnsDate() throws {
        let data = Data("""
            {
                "date": "2021-05"
            }
        """.utf8)
        let expectedResult = Date(timeIntervalSince1970: 1_619_827_200)

        let container = try decoder.decode(Container.self, from: data)
        let result = container.date

        #expect(result == expectedResult)
    }

    @Test("decoding when invalid date throws decoding error")
    func decodingWhenInvalidDateThrowsDecodingError() {
        let data = Data("""
            {
                "date": "11111"
            }
        """.utf8)

        #expect(throws: (any Error).self) {
            try decoder.decode(Container.self, from: data)
        }
    }

}

private struct Container: Decodable, Equatable {

    let date: Date

}
