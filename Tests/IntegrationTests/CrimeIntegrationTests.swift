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
import PoliceDataKit
import XCTest

final class CrimeIntegrationTests: XCTestCase {

    var crimeService: CrimeService!

    override func setUp() {
        super.setUp()
        crimeService = CrimeService()
    }

    override func tearDown() {
        crimeService = nil
        super.tearDown()
    }

    func testStreetLevelCrimesAtCoordinateForLeedsCityCentre() async throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.streetLevelCrimes(at: leedsCityCentreCoordinate, date: date)

        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testStreetLevelCrimesInCoordinatesForGloucesterCityCentre() async throws {
        let boundary = [
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132),
            CLLocationCoordinate2D(latitude: 51.86732, longitude: -2.23382),
            CLLocationCoordinate2D(latitude: 51.86377, longitude: -2.23746),
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132)
        ]
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.streetLevelCrimes(in: boundary, date: date)

        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testCrimesForStreetAtSaundersWayLondon() async throws {
        let saundersWayLondonStreetID = 1_705_005
        let date = try XCTUnwrap(Date(isoString: "2023-02-01T12:00:00Z"))

        let crimes = try await crimeService.crimes(forStreet: saundersWayLondonStreetID, date: date)

        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testCrimesWithNoLocationForHertfordshireConstabulary() async throws {
        let policeForceID = "hertfordshire"
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.crimesWithNoLocation(inPoliceForce: policeForceID, date: date)

        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testCrimesAtCoordinateForLeedsCityCentre() async throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.crimes(at: leedsCityCentreCoordinate, date: date)

        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testCrimesWithNoLocationInPoliceForceForSurrey() async throws {
        let policeForceID = "surrey"
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimes = try await crimeService.crimesWithNoLocation(inPoliceForce: policeForceID, date: date)

        XCTAssertGreaterThan(crimes.count, 0)
    }

    func testCrimeCategories() async throws {
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let crimeCategories = try await crimeService.crimeCategories(forDate: date)

        XCTAssertGreaterThan(crimeCategories.count, 0)
    }

    func testLatestDataDateReturnsDate() async throws {
        let currentDate = Date()

        let date = try await retry {
            try await self.crimeService.latestDataDate()
        }

        XCTAssertLessThanOrEqual(date, currentDate)
    }

}
