//
//  CrimesEndpointTests.swift
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

final class CrimesEndpointTests: XCTestCase {

    func testStreetLevelCrimesAtSpecificPointEndpointReturnsURL() throws {
        let coordinate = CLLocationCoordinate2D(latitude: 2.345, longitude: -1.234)
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(
            string: "/crimes-street/all-crime?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=1970-01"
        ))

        let path = CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testStreetLevelCrimesInCustomAreaEndpointReturnURL() throws {
        let coordinates = CLLocationCoordinate2D.mocks
        let poly = coordinates.map { "\($0.latitude),\($0.longitude)" }.joined(separator: ":")
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/crimes-street/all-crime?poly=\(poly)&date=1970-01"))

        let path = CrimesEndpoint.streetLevelCrimesInArea(coordinates: coordinates, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesAtLocationForStreetEndpointReturnsURL() throws {
        let streetID = 12345
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/crimes-at-location?location_id=\(streetID)&date=1970-01"))

        let path = CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesAtLocationAtSpecificPointEndpointReturnsURL() throws {
        let coordinate = CLLocationCoordinate2D(latitude: 2.345, longitude: -1.234)
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(
            string: "/crimes-at-location?lat=\(coordinate.latitude)&lng=\(coordinate.longitude)&date=1970-01"
        ))

        let path = CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCrimesWithNoLocationEndpointReturnsURL() throws {
        let categoryID = "all-crime"
        let policeForceID = "leicestershire"
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(
            string: "/crimes-no-location?category=\(categoryID)&force=\(policeForceID)&date=1970-01"
        ))

        let path = CrimesEndpoint.crimesWithNoLocation(
            categoryID: categoryID,
            policeForceID: policeForceID,
            date: date
        ).path

        XCTAssertEqual(path, expectedPath)
    }

    func testCategoriesEndpointReturnsURL() throws {
        let date = Date(timeIntervalSince1970: 0)
        let expectedPath = try XCTUnwrap(URL(string: "/crime-categories?date=1970-01"))

        let path = CrimesEndpoint.categories(date: date).path

        XCTAssertEqual(path, expectedPath)
    }

}
