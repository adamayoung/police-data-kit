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

import Foundation
@testable import PoliceDataKit
import Testing

@Suite("PoliceForcesEndpoint")
struct PoliceForcesEndpointTests {

    @Test("list endpoint returns u r l")
    func listEndpointReturnsURL() throws {
        let expectedPath = try #require(URL(string: "/forces"))

        let path = PoliceForcesEndpoint.list.path

        #expect(path == expectedPath)
    }

    @Test("details endpoint returns u r l")
    func detailsEndpointReturnsURL() throws {
        let id = "leicestershire"
        let expectedPath = try #require(URL(string: "/forces/\(id)"))

        let path = PoliceForcesEndpoint.details(id: id).path

        #expect(path == expectedPath)
    }

    @Test("senior officers endpoint returns u r l")
    func seniorOfficersEndpointReturnsURL() throws {
        let policeForceID = "leicestershire"
        let expectedPath = try #require(URL(string: "/forces/\(policeForceID)/people"))

        let path = PoliceForcesEndpoint.seniorOfficers(policeForceID: policeForceID).path

        #expect(path == expectedPath)
    }

}
