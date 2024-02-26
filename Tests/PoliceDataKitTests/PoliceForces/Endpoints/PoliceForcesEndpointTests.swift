//
//  PoliceForcesEndpointTests.swift
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

final class PoliceForcesEndpointTests: XCTestCase {

    func testListEndpointReturnsURL() throws {
        let expectedPath = try XCTUnwrap(URL(string: "/forces"))

        let path = PoliceForcesEndpoint.list.path

        XCTAssertEqual(path, expectedPath)
    }

    func testDetailsEndpointReturnsURL() throws {
        let id = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/forces/\(id)"))

        let path = PoliceForcesEndpoint.details(id: id).path

        XCTAssertEqual(path, expectedPath)
    }

    func testSeniorOfficersEndpointReturnsURL() throws {
        let policeForceID = "leicestershire"
        let expectedPath = try XCTUnwrap(URL(string: "/forces/\(policeForceID)/people"))

        let path = PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID).path

        XCTAssertEqual(path, expectedPath)
    }

}
