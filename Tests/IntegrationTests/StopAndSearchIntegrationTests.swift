//
//  StopAndSearchIntegrationTests.swift
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

@Suite("Stop and search integration", .tags(.integration))
struct StopAndSearchIntegrationTests {

    let stopAndSearchService: StopAndSearchService

    init() {
        self.stopAndSearchService = StopAndSearchService()
    }

    @Test("stop and searches at coordinate for Gloucester")
    func stopAndSearchesAtCoordinateForGloucester() async throws {
        let gloucesterCoordinate = CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.2413)
        let date = try #require(Date(isoString: "2023-03-01T12:00:00Z"))

        let stopAndSearches = try await stopAndSearchService.stopAndSearches(at: gloucesterCoordinate, date: date)

        #expect(!stopAndSearches.isEmpty)
    }

    @Test("stop and searches in coordinates for Gloucester City Centre")
    func stopAndSearchesInCoordinatesForGloucesterCityCentre() async throws {
        let boundary = [
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132),
            CLLocationCoordinate2D(latitude: 51.86732, longitude: -2.23382),
            CLLocationCoordinate2D(latitude: 51.86377, longitude: -2.23746),
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132)
        ]
        let date = try #require(Date(isoString: "2023-01-01T12:00:00Z"))

        let stopAndSearches = try await stopAndSearchService.stopAndSearches(in: boundary, date: date)

        #expect(!stopAndSearches.isEmpty)
    }

    @Test("stop and searches at location for Bond Street London")
    func stopAndSearchesAtLocationForBondStreetLondon() async throws {
        let bondStreetLondonStreetID = 2_342_948
        let date = try #require(Date(isoString: "2023-03-01T12:00:00Z"))

        let stopAndSearches = try await stopAndSearchService.stopAndSearches(
            atLocation: bondStreetLondonStreetID,
            date: date
        )

        #expect(!stopAndSearches.isEmpty)
    }

    @Test("stop and searches with no location for Avon and Somerset Constabulary")
    func stopAndSearchesWithNoLocationForAvonAndSomersetConstabulary() async throws {
        let policeForceID = "avon-and-somerset"
        let date = try #require(Date(isoString: "2022-06-01T12:00:00Z"))

        let stopAndSearches = try await stopAndSearchService.stopAndSearchesWithNoLocation(
            forPoliceForce: policeForceID,
            date: date
        )

        #expect(!stopAndSearches.isEmpty)
    }

    @Test("stop and searches for police force for Cumbria Constabulary")
    func stopAndSearchesForPoliceForceForCumbriaConstabulary() async throws {
        let policeForceID = "cumbria"
        let date = try #require(Date(isoString: "2022-06-01T12:00:00Z"))

        let stopAndSearches = try await stopAndSearchService.stopAndSearches(forPoliceForce: policeForceID, date: date)

        #expect(!stopAndSearches.isEmpty)
    }

}
