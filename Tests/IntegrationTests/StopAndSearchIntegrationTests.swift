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

import Combine
import CoreLocation
import PoliceDataKit
import XCTest

final class StopAndSearchIntegrationTests: XCTestCase {

    var stopAndSearchService: StopAndSearchService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
        stopAndSearchService = StopAndSearchService()
    }

    override func tearDown() {
        stopAndSearchService = nil
        cancellables = nil
        super.tearDown()
    }

    func testStopAndSearchesAtCoordinateForGloucester() async throws {
        let gloucesterCoordinate = CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.2413)
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let stopAndSearches = try await stopAndSearchService.stopAndSearches(at: gloucesterCoordinate, date: date)

        XCTAssertGreaterThan(stopAndSearches.count, 0)
    }

    func testStopAndSearchesPublisherAtCoordinateForLeedsCityCentre() throws {
        let leedsCityCentreCoordinate = CLLocationCoordinate2D(latitude: 53.797927, longitude: -1.541522)
        let date = try XCTUnwrap(Date(isoString: "2023-02-01T12:00:00Z"))

        let expectation = expectation(description: "StopAndSearchesPublisher")
        var result: [StopAndSearch]?
        stopAndSearchService.stopAndSearchesPublisher(at: leedsCityCentreCoordinate, date: date)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { stopAndSearches in
                result = stopAndSearches
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        let stopAndSearches = try XCTUnwrap(result)
        XCTAssertGreaterThan(stopAndSearches.count, 0)
    }

    func testStopAndSearchesInCoordinatesForGloucesterCityCentre() async throws {
        let boundary = [
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132),
            CLLocationCoordinate2D(latitude: 51.86732, longitude: -2.23382),
            CLLocationCoordinate2D(latitude: 51.86377, longitude: -2.23746),
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132)
        ]
        let date = try XCTUnwrap(Date(isoString: "2023-01-01T12:00:00Z"))

        let stopAndSearches = try await stopAndSearchService.stopAndSearches(in: boundary, date: date)

        XCTAssertGreaterThan(stopAndSearches.count, 0)
    }

    func testStopAndSearchesPublisherInCoordinatesForGloucesterCityCentre() throws {
        let boundary = [
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132),
            CLLocationCoordinate2D(latitude: 51.86732, longitude: -2.23382),
            CLLocationCoordinate2D(latitude: 51.86377, longitude: -2.23746),
            CLLocationCoordinate2D(latitude: 51.86703, longitude: -2.24132)
        ]
        let date = try XCTUnwrap(Date(isoString: "2022-12-01T12:00:00Z"))

        let expectation = expectation(description: "StopAndSearchesPublisher")
        var result: [StopAndSearch]?
        stopAndSearchService.stopAndSearchesPublisher(in: boundary, date: date)
            .sink { _ in
                expectation.fulfill()
            } receiveValue: { stopAndSearches in
                result = stopAndSearches
            }
            .store(in: &cancellables)

        wait(for: [expectation])

        let stopAndSearches = try XCTUnwrap(result)
        XCTAssertGreaterThan(stopAndSearches.count, 0)
    }

    func testStopAndSearchesAtLocationForBondStreetLondon() async throws {
        let bondStreetLondonStreetID = 2_342_948
        let date = try XCTUnwrap(Date(isoString: "2023-03-01T12:00:00Z"))

        let stopAndSearches = try await stopAndSearchService.stopAndSearches(
            atLocation: bondStreetLondonStreetID,
            date: date
        )

        XCTAssertGreaterThan(stopAndSearches.count, 0)
    }

    func testStopAndSearchesWithNoLocationForAvonAndSomersetConstabulary() async throws {
        let policeForceID = "avon-and-somerset"
        let date = try XCTUnwrap(Date(isoString: "2022-06-01T12:00:00Z"))

        let stopAndSearches = try await stopAndSearchService.stopAndSearchesWithNoLocation(
            forPoliceForce: policeForceID,
            date: date
        )

        XCTAssertGreaterThan(stopAndSearches.count, 0)
    }

    func testStopAndSearchesForPoliceForceForCumbriaConstabulary() async throws {
        let policeForceID = "cumbria"
        let date = try XCTUnwrap(Date(isoString: "2022-06-01T12:00:00Z"))

        let stopAndSearches = try await stopAndSearchService.stopAndSearches(forPoliceForce: policeForceID, date: date)

        XCTAssertGreaterThan(stopAndSearches.count, 0)
    }

}
