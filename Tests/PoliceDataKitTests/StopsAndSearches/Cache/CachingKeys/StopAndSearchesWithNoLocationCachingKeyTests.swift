//
//  StopAndSearchesWithNoLocationCachingKeyTests.swift
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

final class StopAndSearchesWithNoLocationCachingKeyTests: XCTestCase {

    func testKeyValue() {
        let policeForceID = "leicestershire"
        let date = Date(timeIntervalSince1970: 0)

        let cacheKey = StopAndSearchesWithNoLocationCachingKey(policeForceID: policeForceID, date: date)

        XCTAssertEqual(
            cacheKey.keyValue,
            "stop-and-searches-with-no-location-for-police-force-\(policeForceID)-date-1970-01"
        )
    }

}
