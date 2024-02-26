//
//  StopAndSearchTypeTests.swift
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

final class StopAndSearchTypeTests: XCTestCase {

    func testPersonSearch() {
        let result = StopAndSearchType(rawValue: "Person search")

        XCTAssertEqual(result, .personSearch)
    }

    func testVehicleSearch() {
        let result = StopAndSearchType(rawValue: "Vehicle search")

        XCTAssertEqual(result, .vehicleSearch)
    }

    func testPersonAndVehicleSearch() {
        let result = StopAndSearchType(rawValue: "Person and Vehicle search")

        XCTAssertEqual(result, .personAndVehicleSearch)
    }

    func testDescriptionWhenPersonSearchReturnDescription() {
        let expectedResult = "Person search"

        let result = StopAndSearchType.personSearch.rawValue

        XCTAssertEqual(result, expectedResult)
    }

    func testDescriptionWhenVehicleSearchReturnDescription() {
        let expectedResult = "Vehicle search"

        let result = StopAndSearchType.vehicleSearch.rawValue

        XCTAssertEqual(result, expectedResult)
    }

    func testDescriptionWhenPersonAndVehicleSearchReturnDescription() {
        let expectedResult = "Person and Vehicle search"

        let result = StopAndSearchType.personAndVehicleSearch.rawValue

        XCTAssertEqual(result, expectedResult)
    }

}
