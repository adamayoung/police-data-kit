//
//  NeighbourhoodTests.swift
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

final class NeighbourhoodTests: XCTestCase {

    func testDecodeReturnsNeighbourhood() throws {
        let result = try JSONDecoder.policeDataAPI.decode(Neighbourhood.self, fromResource: "neighbourhood")

        XCTAssertEqual(result, .mock)
    }

    func testPopulationReturnsPopulation() throws {
        let expectedResult = Neighbourhood.mock.population

        let result = try JSONDecoder.policeDataAPI.decode(Neighbourhood.self, fromResource: "neighbourhood")

        XCTAssertEqual(result.population, expectedResult)
    }

    func testDecodeWithEmptyPoliceForceWebsiteURL() throws {
        let result = try JSONDecoder.policeDataAPI.decode(
            Neighbourhood.self,
            fromResource: "neighbourhood-empty-force-url"
        )

        XCTAssertNil(result.policeForceWebsiteURL)
    }

    func testDecodedWithHTMLInName() throws {
        let expectedResult = "Leake & Keyworth"

        let result = try JSONDecoder.policeDataAPI.decode(
            Neighbourhood.self,
            fromResource: "neighbourhood-html-in-name"
        )

        XCTAssertEqual(result.name, expectedResult)
    }

}
