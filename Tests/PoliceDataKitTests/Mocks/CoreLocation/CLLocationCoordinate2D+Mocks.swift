//
//  CLLocationCoordinate2D+Mocks.swift
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

extension CLLocationCoordinate2D {

    static var mock: Self {
        CLLocationCoordinate2D(latitude: 52.6389, longitude: -1.13619)
    }

    static var mocks: [Self] {
        [
            CLLocationCoordinate2D(
                latitude: 52.6394052587,
                longitude: -1.1458618876
            ),
            CLLocationCoordinate2D(
                latitude: 52.6389452755,
                longitude: -1.1457057759
            ),
            CLLocationCoordinate2D(
                latitude: 52.6383706746,
                longitude: -1.1455755443
            )
        ]
    }

    static var outsideAvailableDataRegion: Self {
        CLLocationCoordinate2D(latitude: 32.6389, longitude: 4.13619)
    }

}
