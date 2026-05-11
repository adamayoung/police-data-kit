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
import Testing

@Suite("Police force integration", .integrationGate, .tags(.integration))
struct PoliceForceIntegrationTests {

    let policeForceService: PoliceForceService

    init() {
        self.policeForceService = PoliceForceService()
    }

    @Test("police forces returns forces")
    func policeForces() async throws {
        let policeForces = try await retry {
            try await policeForceService.policeForces()
        }

        #expect(!policeForces.isEmpty)
    }

    @Test("police force with Cambridgeshire Constabulary")
    func policeForceWithCambridgeshireConstabulary() async throws {
        let policeForceID = "cambridgeshire"

        let policeForce = try await retry {
            try await policeForceService.policeForce(withID: policeForceID)
        }

        #expect(policeForce.id == policeForceID)
    }

    @Test("police force with Suffolk Constabulary")
    func policeForceWithSuffolkConstabulary() async throws {
        let policeForceID = "suffolk"

        let policeForce = try await retry {
            try await policeForceService.policeForce(withID: policeForceID)
        }

        #expect(policeForce.id == policeForceID)
    }

    @Test("police force with invalid police force throws not found")
    func policeForceWithInvalidPoliceForce() async throws {
        let policeForceID = "aaa"

        var policeForceError: PoliceForceError?
        do {
            _ = try await retryOnRateLimit { try await policeForceService.policeForce(withID: policeForceID) }
        } catch let error as PoliceForceError {
            policeForceError = error
        }

        #expect(policeForceError == .notFound)
    }

    @Test("senior officers for Nottinghamshire Police")
    func seniorOfficersForWarwickshirePolice() async throws {
        let policeForceID = "nottinghamshire"

        let policeOfficers = try await retry {
            try await policeForceService.seniorOfficers(inPoliceForce: policeForceID)
        }

        #expect(!policeOfficers.isEmpty)
    }

    @Test("senior officers for Nottinghamshire Police")
    func seniorOfficersForNottinghamshirePolice() async throws {
        let policeForceID = "nottinghamshire"

        let policeOfficers = try await retry {
            try await policeForceService.seniorOfficers(inPoliceForce: policeForceID)
        }

        #expect(!policeOfficers.isEmpty)
    }

    @Test("senior officers for invalid police force throws not found")
    func seniorOfficersForInvalidPoliceForce() async throws {
        let policeForceID = "bbb"

        var policeForceError: PoliceForceError?
        do {
            _ = try await retryOnRateLimit { try await policeForceService.seniorOfficers(inPoliceForce: policeForceID) }
        } catch let error as PoliceForceError {
            policeForceError = error
        }

        #expect(policeForceError == .notFound)
    }

}
