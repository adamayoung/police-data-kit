//
//  CrimeIntegrationTests.swift
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

@Suite("Crime integration", .tags(.integration))
struct CrimeIntegrationTests {

    let crimeService: CrimeService

    init() {
        self.crimeService = CrimeService()
    }

    @Test("street level crimes at coordinate for Leeds City Centre")
    func streetLevelCrimesAtCoordinateForLeedsCityCentre() async throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)
        let date = try #require(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.streetLevelCrimes(at: leedsCityCentreCoordinate, date: date)

        #expect(!crimes.isEmpty)
    }

    @Test("street level crimes in coordinates for Gloucester City Centre")
    func streetLevelCrimesInCoordinatesForGloucesterCityCentre() async throws {
        let boundary = [
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132),
            CLLocationCoordinate2D(latitude: 51.86732, longitude: -2.23382),
            CLLocationCoordinate2D(latitude: 51.86377, longitude: -2.23746),
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132)
        ]
        let date = try #require(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.streetLevelCrimes(in: boundary, date: date)

        #expect(!crimes.isEmpty)
    }

    @Test("crimes for street at Saunders Way London")
    func crimesForStreetAtSaundersWayLondon() async throws {
        let saundersWayLondonStreetID = 1_705_005
        let date = try #require(Date(isoString: "2023-02-01T12:00:00Z"))

        let crimes = try await crimeService.crimes(forStreet: saundersWayLondonStreetID, date: date)

        #expect(!crimes.isEmpty)
    }

    @Test("crimes with no location for Hertfordshire Constabulary")
    func crimesWithNoLocationForHertfordshireConstabulary() async throws {
        let policeForceID = "hertfordshire"
        let date = try #require(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.crimesWithNoLocation(inPoliceForce: policeForceID, date: date)

        #expect(!crimes.isEmpty)
    }

    @Test("crimes at coordinate for Leeds City Centre")
    func crimesAtCoordinateForLeedsCityCentre() async throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)
        let date = try #require(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.crimes(at: leedsCityCentreCoordinate, date: date)

        #expect(!crimes.isEmpty)
    }

    @Test("crimes with no location in police force for Surrey")
    func crimesWithNoLocationInPoliceForceForSurrey() async throws {
        let policeForceID = "surrey"
        let date = try #require(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.crimesWithNoLocation(inPoliceForce: policeForceID, date: date)

        #expect(!crimes.isEmpty)
    }

    @Test("crime categories returns categories")
    func crimeCategories() async throws {
        let date = try #require(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimeCategories = try await crimeService.crimeCategories(forDate: date)

        #expect(!crimeCategories.isEmpty)
    }

    @Test("latest data date returns date")
    func latestDataDateReturnsDate() async throws {
        let currentDate = Date()

        let date = try await retry {
            try await crimeService.latestDataDate()
        }

        #expect(date <= currentDate)
    }

}
