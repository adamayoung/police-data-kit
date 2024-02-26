//
//  OutcomesEndpointTests.swift
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
@testable import PoliceDataKit
import XCTest

final class OutcomesEndpointTests: XCTestCase {

    func testStreetLevelOutcomesForStreetEndpointReturnsURL() throws {
        let streetID = 12345
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/outcomes-at-location?location_id=\(streetID)&date=1970-01"))

        let path = OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelOutcomesAtSpecificPointEndpointReturnsURL() throws {
        let coordinate = CLLocationCoordinate2D(latitude: 2.345, longitude: -1.234)
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(
            string: "/outcomes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=1970-01"
        ))

        let path = OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelOutcomesInAreaEndpointReturnsURL() throws {
        let coordinates = CLLocationCoordinate2D.mocks
        let coordinatePairs = coordinates.map { "\($0.latitude),\($0.longitude)" }
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(
            string: "/outcomes-at-location?poly=\(coordinatePairs.joined(separator: ":"))&date=1970-01"
        ))

        let path = OutcomesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCaseHistoryReturnsURL() throws {
        let crimeID = CaseHistory.mock.crime.crimeID
        let expectedPath = try XCTUnwrap(URL(string: "/outcomes-for-crime/\(crimeID)"))

        let path = OutcomesEndpoint.caseHistory(crimeID: crimeID).path

        XCTAssertEqual(path, expectedPath)
    }

}
