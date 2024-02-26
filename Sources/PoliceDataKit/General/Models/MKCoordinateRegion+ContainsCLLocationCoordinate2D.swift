//
//  MKCoordinateRegion+ContainsCLLocationCoordinate2D.swift
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

import Foundation
import MapKit

public extension MKCoordinateRegion {

    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        let northWestCoordinate = northWestCoordinate
        let southEastRightCoordinate = southEastRightCoordinate

        return coordinate.latitude >= northWestCoordinate.latitude
            && coordinate.longitude >= northWestCoordinate.longitude
            && coordinate.latitude <= southEastRightCoordinate.latitude
            && coordinate.longitude <= southEastRightCoordinate.longitude
    }

}

extension MKCoordinateRegion {

    private var northWestCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: center.latitude - (span.latitudeDelta / 2.0),
            longitude: center.longitude - (span.longitudeDelta / 2.0)
        )
    }

    private var southEastRightCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: center.latitude + (span.latitudeDelta / 2.0),
            longitude: center.longitude + (span.longitudeDelta / 2.0)
        )
    }

}
