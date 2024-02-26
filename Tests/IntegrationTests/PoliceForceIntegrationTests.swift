//
//  PoliceForceIntegrationTests.swift
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

import PoliceDataKit
import XCTest

final class PoliceForceIntegrationTests: XCTestCase {

    var policeForceService: PoliceForceService!

    override func setUp() {
        super.setUp()
        policeForceService = PoliceForceService()
    }

    override func tearDown() {
        policeForceService = nil
        super.tearDown()
    }

    func testPoliceForces() async throws {
        let policeForces = try await policeForceService.policeForces()

        XCTAssertGreaterThan(policeForces.count, 0)
    }

    func testPoliceForceWithCambridgeshireConstabulary() async throws {
        let policForceID = "cambridgeshire"

        let policeForce = try await policeForceService.policeForce(withID: policForceID)

        XCTAssertEqual(policeForce.id, policForceID)
    }

    func testPoliceForceWithSulfolkConstabulary() async throws {
        let policForceID = "suffolk"

        let policeForce = try await policeForceService.policeForce(withID: policForceID)

        XCTAssertEqual(policeForce.id, policForceID)
    }

    func testPoliceForceWithInvalidPoliceForce() async throws {
        let policForceID = "aaa"

        var policeForceError: PoliceForceError?
        do {
            _ = try await policeForceService.policeForce(withID: policForceID)
        } catch let error {
            policeForceError = error as? PoliceForceError
        }

        XCTAssertEqual(policeForceError, .notFound)
    }

    func testSeniorOfficersForWarwickshirePolice() async throws {
        let policForceID = "warwickshire"

        let policeOfficers = try await policeForceService.seniorOfficers(inPoliceForce: policForceID)

        XCTAssertGreaterThan(policeOfficers.count, 0)
    }

    func testSeniorOfficersForNottinghamshirePolice() async throws {
        let policForceID = "nottinghamshire"

        let policeOfficers = try await policeForceService.seniorOfficers(inPoliceForce: policForceID)

        XCTAssertGreaterThan(policeOfficers.count, 0)
    }

    func testSeniorOfficersForInvalidPoliceForce() async throws {
        let policForceID = "bbb"

        var policeForceError: PoliceForceError?
        do {
            _ = try await policeForceService.seniorOfficers(inPoliceForce: policForceID)
        } catch let error {
            policeForceError = error as? PoliceForceError
        }

        XCTAssertEqual(policeForceError, .notFound)
    }

}
