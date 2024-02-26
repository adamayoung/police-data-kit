//
//  MKCoordinateRegionContainsCoordinateTests.swift
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

import MapKit
@testable import PoliceDataKit
import XCTest

final class MKCoordinateRegionDataModelContainsTests: XCTestCase {

    var region: MKCoordinateRegion!

    override func setUp() {
        super.setUp()
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    }

    override func tearDown() {
        region = nil
        super.tearDown()
    }

    func testContainsWhenCoordinateIsNorthOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(latitude: -2, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsNorthEastOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(latitude: -2, longitude: 2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsEastOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsSouthEastOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(latitude: 2, longitude: 2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsSouthOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(latitude: 2, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsSouthWestOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(latitude: 2, longitude: -2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsWestOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(latitude: 0, longitude: -2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsNorthWestOfRegionReturnsFalse() {
        let coordinate = CLLocationCoordinate2D(latitude: -2, longitude: -2)

        let result = region.contains(coordinate: coordinate)

        XCTAssertFalse(result)
    }

    func testContainsWhenCoordinateIsInCenterOfRegionReturnsTrue() {
        let coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsNorthInsideOfRegionReturnsTrue() {
        let coordinate = CLLocationCoordinate2D(latitude: -0.5, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsNorthEastInsideOfRegionReturnsTrue() {
        let coordinate = CLLocationCoordinate2D(latitude: -0.5, longitude: 0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsEastInsideOfRegionReturnsTrue() {
        let coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsSouthEastInsideOfRegionReturnsTrue() {
        let coordinate = CLLocationCoordinate2D(latitude: 0.5, longitude: 0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsSouthInsideOfRegionReturnsTrue() {
        let coordinate = CLLocationCoordinate2D(latitude: 0.5, longitude: 0)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsSouthWestInsideOfRegionReturnsTrue() {
        let coordinate = CLLocationCoordinate2D(latitude: 0.5, longitude: -0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsWestInsideOfRegionReturnsTrue() {
        let coordinate = CLLocationCoordinate2D(latitude: 0, longitude: -0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

    func testContainsWhenCoordinateIsNorthWestInsideOfRegionReturnsTrue() {
        let coordinate = CLLocationCoordinate2D(latitude: -0.5, longitude: -0.5)

        let result = region.contains(coordinate: coordinate)

        XCTAssertTrue(result)
    }

}
