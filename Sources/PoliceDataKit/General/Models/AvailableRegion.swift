//
//  AvailableRegion.swift
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

struct AvailableRegion {

    let centerLatitude: CLLocationDegrees
    let centerLongitude: CLLocationDegrees
    let latitudeDelta: CLLocationDegrees
    let longitudeDelta: CLLocationDegrees

    func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        let minLat = centerLatitude - latitudeDelta / 2
        let maxLat = centerLatitude + latitudeDelta / 2
        let minLng = centerLongitude - longitudeDelta / 2
        let maxLng = centerLongitude + longitudeDelta / 2
        return (minLat ... maxLat).contains(coordinate.latitude)
            && (minLng ... maxLng).contains(coordinate.longitude)
    }

}

extension AvailableRegion {

    static let availableDataRegion = AvailableRegion(
        centerLatitude: 54.4661645479556,
        centerLongitude: -3.1076525162671667,
        latitudeDelta: 13.0738,
        longitudeDelta: 11.4748
    )

}
