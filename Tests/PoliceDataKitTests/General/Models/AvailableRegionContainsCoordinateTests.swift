//
//  AvailableRegionContainsCoordinateTests.swift
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
import Testing

@Suite("AvailableRegion contains coordinate")
struct AvailableRegionContainsCoordinateTests {

    let region: AvailableRegion

    init() {
        self.region = AvailableRegion(
            centerLatitude: 0,
            centerLongitude: 0,
            latitudeDelta: 1,
            longitudeDelta: 1
        )
    }

    @Test(
        "contains when coordinate is outside region returns false",
        arguments: [
            CLLocationCoordinate2D(latitude: -2, longitude: 0),
            CLLocationCoordinate2D(latitude: -2, longitude: 2),
            CLLocationCoordinate2D(latitude: 0, longitude: 2),
            CLLocationCoordinate2D(latitude: 2, longitude: 2),
            CLLocationCoordinate2D(latitude: 2, longitude: 0),
            CLLocationCoordinate2D(latitude: 2, longitude: -2),
            CLLocationCoordinate2D(latitude: 0, longitude: -2),
            CLLocationCoordinate2D(latitude: -2, longitude: -2)
        ]
    )
    func containsWhenCoordinateIsOutsideRegionReturnsFalse(coordinate: CLLocationCoordinate2D) {
        let result = region.contains(coordinate: coordinate)

        #expect(!result)
    }

    @Test(
        "contains when coordinate is inside region returns true",
        arguments: [
            CLLocationCoordinate2D(latitude: 0, longitude: 0),
            CLLocationCoordinate2D(latitude: -0.4, longitude: 0),
            CLLocationCoordinate2D(latitude: -0.4, longitude: 0.4),
            CLLocationCoordinate2D(latitude: 0, longitude: 0.4),
            CLLocationCoordinate2D(latitude: 0.4, longitude: 0.4),
            CLLocationCoordinate2D(latitude: 0.4, longitude: 0),
            CLLocationCoordinate2D(latitude: 0.4, longitude: -0.4),
            CLLocationCoordinate2D(latitude: 0, longitude: -0.4),
            CLLocationCoordinate2D(latitude: -0.4, longitude: -0.4)
        ]
    )
    func containsWhenCoordinateIsInsideRegionReturnsTrue(coordinate: CLLocationCoordinate2D) {
        let result = region.contains(coordinate: coordinate)

        #expect(result)
    }

}
