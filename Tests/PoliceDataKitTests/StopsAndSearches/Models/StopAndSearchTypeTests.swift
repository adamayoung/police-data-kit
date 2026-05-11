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
import Testing

@Suite("StopAndSearchType")
struct StopAndSearchTypeTests {

    @Test("person search")
    func personSearch() {
        let result = StopAndSearchType(rawValue: "Person search")

        #expect(result == .personSearch)
    }

    @Test("vehicle search")
    func vehicleSearch() {
        let result = StopAndSearchType(rawValue: "Vehicle search")

        #expect(result == .vehicleSearch)
    }

    @Test("person and vehicle search")
    func personAndVehicleSearch() {
        let result = StopAndSearchType(rawValue: "Person and Vehicle search")

        #expect(result == .personAndVehicleSearch)
    }

    @Test("description when person search return description")
    func descriptionWhenPersonSearchReturnDescription() {
        let expectedResult = "Person search"

        let result = StopAndSearchType.personSearch.rawValue

        #expect(result == expectedResult)
    }

    @Test("description when vehicle search return description")
    func descriptionWhenVehicleSearchReturnDescription() {
        let expectedResult = "Vehicle search"

        let result = StopAndSearchType.vehicleSearch.rawValue

        #expect(result == expectedResult)
    }

    @Test("description when person and vehicle search return description")
    func descriptionWhenPersonAndVehicleSearchReturnDescription() {
        let expectedResult = "Person and Vehicle search"

        let result = StopAndSearchType.personAndVehicleSearch.rawValue

        #expect(result == expectedResult)
    }

}
