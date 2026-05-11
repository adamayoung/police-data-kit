//
//  OutcomeIntegrationTests.swift
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

import CoreLocation
import Foundation
import PoliceDataKit
import Testing

@Suite("Outcome integration", .integrationGate, .tags(.integration))
struct OutcomeIntegrationTests {

    let outcomeService: OutcomeService

    init() {
        self.outcomeService = OutcomeService()
    }

    @Test("street level outcomes for street for Princes Street London")
    func streetLevelOutcomesForStreetForPrincesStreetLondon() async throws {
        let princesStreetLondonStreetID = 1_675_924
        let date = try #require(Date(isoString: "2025-09-01T12:00:00Z"))

        let outcomes = try await retry {
            try await outcomeService.streetLevelOutcomes(forStreet: princesStreetLondonStreetID, date: date)
        }

        #expect(!outcomes.isEmpty)
    }

    @Test("street level outcomes at coordinate for Leeds City Centre")
    func streetLevelOutcomesAtCoordinateForLeedsCityCentre() async throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)
        let date = try #require(Date(isoString: "2025-09-01T12:00:00Z"))

        let outcomes = try await retry {
            try await outcomeService.streetLevelOutcomes(at: leedsCityCentreCoordinate, date: date)
        }

        #expect(!outcomes.isEmpty)
    }

    @Test("street level outcomes in coordinates for Gloucester City Centre")
    func streetLevelOutcomesInCoordinatesForGloucesterCityCentre() async throws {
        let boundary = [
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132),
            CLLocationCoordinate2D(latitude: 51.86732, longitude: -2.23382),
            CLLocationCoordinate2D(latitude: 51.86377, longitude: -2.23746),
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132)
        ]
        let date = try #require(Date(isoString: "2025-09-01T12:00:00Z"))

        let outcomes = try await retry {
            try await outcomeService.streetLevelOutcomes(in: boundary, date: date)
        }

        #expect(!outcomes.isEmpty)
    }

    @Test("case history for crime")
    func caseHistoryForCrime() async throws {
        let crimeID = "9442760eab1f3e579c0a22d30258453dda5a16c472720210f2ec08e6034fe5c0"

        let caseHistory = try await retry {
            try await outcomeService.caseHistory(forCrime: crimeID)
        }

        #expect(caseHistory.crime.crimeID == crimeID)
    }

}
