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

import CoreLocation
import MapKit
@testable import PoliceDataKit
import Testing

@Suite("MKCoordinateRegion contains coordinate")
struct MKCoordinateRegionDataModelContainsTests {

    let region: MKCoordinateRegion

    init() {
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        )
    }

    @Test(
        "contains when coordinate is outside region returns false",
        arguments: [
            CLLocationCoordinate2D(latitude: -2, longitude: 0), // north of region
            CLLocationCoordinate2D(latitude: -2, longitude: 2), // north-east
            CLLocationCoordinate2D(latitude: 0, longitude: 2), // east
            CLLocationCoordinate2D(latitude: 2, longitude: 2), // south-east
            CLLocationCoordinate2D(latitude: 2, longitude: 0), // south
            CLLocationCoordinate2D(latitude: 2, longitude: -2), // south-west
            CLLocationCoordinate2D(latitude: 0, longitude: -2), // west
            CLLocationCoordinate2D(latitude: -2, longitude: -2) // north-west
        ]
    )
    func containsWhenCoordinateIsOutsideRegionReturnsFalse(coordinate: CLLocationCoordinate2D) {
        let result = region.contains(coordinate: coordinate)

        #expect(!result)
    }

    @Test(
        "contains when coordinate is inside region returns true",
        arguments: [
            CLLocationCoordinate2D(latitude: 0, longitude: 0), // center
            CLLocationCoordinate2D(latitude: -0.5, longitude: 0), // north inside
            CLLocationCoordinate2D(latitude: -0.5, longitude: 0.5), // north-east inside
            CLLocationCoordinate2D(latitude: 0, longitude: 0.5), // east inside
            CLLocationCoordinate2D(latitude: 0.5, longitude: 0.5), // south-east inside
            CLLocationCoordinate2D(latitude: 0.5, longitude: 0), // south inside
            CLLocationCoordinate2D(latitude: 0.5, longitude: -0.5), // south-west inside
            CLLocationCoordinate2D(latitude: 0, longitude: -0.5), // west inside
            CLLocationCoordinate2D(latitude: -0.5, longitude: -0.5) // north-west inside
        ]
    )
    func containsWhenCoordinateIsInsideRegionReturnsTrue(coordinate: CLLocationCoordinate2D) {
        let result = region.contains(coordinate: coordinate)

        #expect(result)
    }

}
