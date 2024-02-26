//
//  NeighbourhoodLocationTests.swift
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

final class NeighbourhoodLocationTests: XCTestCase {

    func testDecodeReturnsLocation() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocation.self, fromResource: "neighbourhood-location")

        XCTAssertEqual(result, .mock)
    }

    func testDecodeWhenTypeIsNill() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocation.self, fromResource: "neighbourhood-location-null-type")

        XCTAssertNil(result.type)
    }

    func testLatitudeReturnsLatitude() throws {
        let expectedResult = NeighbourhoodLocation.mock.coordinate?.latitude

        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocation.self, fromResource: "neighbourhood-location").coordinate?.latitude

        XCTAssertEqual(result, expectedResult)
    }

    func testLongitudeReturnsLongitude() throws {
        let expectedResult = NeighbourhoodLocation.mock.coordinate?.longitude

        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodLocation.self, fromResource: "neighbourhood-location").coordinate?.longitude

        XCTAssertEqual(result, expectedResult)
    }

}
