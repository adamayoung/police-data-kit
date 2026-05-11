//
//  DateFormatter+PoliceDataAPITests.swift
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

@Suite("DateFormatter PoliceDataAPI")
struct DateFormatterPoliceDataAPITests {

    @Test("dateTime formatter returns date")
    func dateTimeFormatterReturnsDate() {
        let dateString = "2021-05-24T10:22:45"
        let expectedResult = "2021-05-24 10:22:45 +0000"
        let dateFormatter = DateFormatter.dateTime

        let result = dateFormatter.date(from: dateString)?.description

        #expect(result == expectedResult)
    }

    @Test("dateTime formatter when invalid date format returns nil")
    func dateTimeFormatterWhenInvalidDateFormatReturnsNil() {
        let dateString = "2021-05-24"
        let dateFormatter = DateFormatter.dateTime

        let result = dateFormatter.date(from: dateString)

        #expect(result == nil)
    }

    @Test("dateTime with timezone offset formatter when UTC returns date")
    func dateTimeWithTimeZoneOffsetFormatterWhenUTCReturnsDate() {
        let dateString = "2020-01-31T12:45:12+00:00"
        let expectedResult = "2020-01-31 12:45:12 +0000"
        let dateFormatter = DateFormatter.dateTimeWithTimeZoneOffset

        let result = dateFormatter.date(from: dateString)?.description

        #expect(result == expectedResult)
    }

    @Test("dateTime with timezone offset formatter when minus five hours returns date")
    func dateTimeWithTimeZoneOffsetFormatterWhenMinusFiveHoursReturnsDate() {
        let dateString = "2019-09-15T21:01:58-05:00"
        let expectedResult = "2019-09-16 02:01:58 +0000"
        let dateFormatter = DateFormatter.dateTimeWithTimeZoneOffset

        let result = dateFormatter.date(from: dateString)?.description

        #expect(result == expectedResult)
    }

    @Test("dateTime with timezone offset formatter when invalid date format returns nil")
    func dateTimeWithTimeZoneOffsetFormatterWhenInvalidDateFormatReturnsNil() {
        let dateString = "2020-01-31"
        let dateFormatter = DateFormatter.dateTimeWithTimeZoneOffset

        let result = dateFormatter.date(from: dateString)

        #expect(result == nil)
    }

    @Test("yearMonth formatter returns date")
    func yearMonthFormatterReturnsDate() {
        let dateString = "2021-02"
        let expectedResult = "2021-02-01 00:00:00 +0000"
        let dateFormatter = DateFormatter.yearMonth

        let result = dateFormatter.date(from: dateString)?.description

        #expect(result == expectedResult)
    }

    @Test("yearMonth formatter when invalid date format returns nil")
    func yearMonthFormatterWhenInvalidDateFormatReturnsDate() {
        let dateString = "2021-02-01"
        let dateFormatter = DateFormatter.yearMonth

        let result = dateFormatter.date(from: dateString)

        #expect(result == nil)
    }

}
