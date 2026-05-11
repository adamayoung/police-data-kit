//
//  GenderTests.swift
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

@Suite("Gender")
struct GenderTests {

    @Test("male raw value returns .male")
    func male() {
        let result = Gender(rawValue: "Male")

        #expect(result == .male)
    }

    @Test("female raw value returns .female")
    func female() {
        let result = Gender(rawValue: "Female")

        #expect(result == .female)
    }

    @Test("description when male returns description")
    func descriptionWhenMaleReturnDescription() {
        let expectedResult = "Male"

        let result = Gender.male.rawValue

        #expect(result == expectedResult)
    }

    @Test("description when female returns description")
    func descriptionWhenVehicleSearchReturnDescription() {
        let expectedResult = "Female"

        let result = Gender.female.rawValue

        #expect(result == expectedResult)
    }

}
