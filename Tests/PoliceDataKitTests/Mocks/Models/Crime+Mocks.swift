//
//  Crime+Mocks.swift
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

extension Crime {

    static var mock: Self {
        Crime(
            id: 81_012_437,
            crimeID: "0e51b9ceb4aedef3f9679481aa11262a6c5ea90a68d0dd0e0002a0b521c445e0",
            context: "",
            categoryID: "violent-crime",
            location: Location(
                street: Street(
                    id: 883_345,
                    name: "On or near Marquis Street"
                ),
                coordinate: CLLocationCoordinate2D(latitude: 52.629909, longitude: -1.132073)
            ),
            locationType: .force,
            locationSubtype: "",
            date: DateFormatter.yearMonth.date(from: "2020-02")!,
            outcomeStatus: OutcomeStatus(
                category: "Status update unavailable",
                date: DateFormatter.yearMonth.date(from: "2020-06")!
            )
        )
    }

    static var mocks: [Self] {
        [
            .mock,
            Crime(
                id: 90_362_519,
                crimeID: "5d512591e5dc9dd264a08c8dc133c3dde5c843d329928d1e6124bfe8fc9216a5",
                context: "",
                categoryID: "criminal-damage-arson",
                location: Location(
                    street: Street(
                        id: 886_204,
                        name: "On or near Ostlers Drive"
                    ),
                    coordinate: CLLocationCoordinate2D(latitude: 52.679277, longitude: -0.740683)
                ),
                locationType: .force,
                locationSubtype: "",
                date: DateFormatter.yearMonth.date(from: "2020-02")!,
                outcomeStatus: OutcomeStatus(
                    category: "Investigation complete; no suspect identified",
                    date: DateFormatter.yearMonth.date(from: "2021-02")!
                )
            )
        ]
    }

}
