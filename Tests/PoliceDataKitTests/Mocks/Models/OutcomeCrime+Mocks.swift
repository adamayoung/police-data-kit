//
//  OutcomeCrime+Mocks.swift
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
@testable import PoliceDataKit

extension OutcomeCrime {

    static var mock: Self {
        OutcomeCrime(
            id: 86_783_916,
            crimeID: "c69de56fd2fcd523ab65b588811caf53e7ff3a577b2bfd2f731173f5f95af99d",
            context: "",
            categoryID: "burglary",
            location: Location(
                street: Street(
                    id: 884_330,
                    name: "On or near Christow Street"
                ),
                coordinate: CLLocationCoordinate2D(latitude: 52.640374, longitude: -1.122319)
            ),
            locationType: .force,
            locationSubtype: "ROAD",
            date: DateFormatter.yearMonth.date(from: "2020-09")!
        )
    }

}
