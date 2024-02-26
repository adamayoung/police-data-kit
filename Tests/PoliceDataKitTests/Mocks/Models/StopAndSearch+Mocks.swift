//
//  StopAndSearch+Mocks.swift
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

extension StopAndSearch {

    static var mock: StopAndSearch {
        StopAndSearch(
            type: .personSearch,
            didInvolvePerson: true,
            gender: .male,
            ageRange: "over 34",
            selfDefinedEthnicity: "White - English/Welsh/Scottish/Northern Irish/British",
            officerDefinedEthnicity: "White",
            legislation: "Police and Criminal Evidence Act 1984 (section 1)",
            objectOfSearch: "Offensive weapons",
            removalOfMoreThanOuterClothing: nil,
            operationName: nil,
            location: Location(
                street: Street(
                    id: 883_415,
                    name: "On or near Shopping Area"
                ),
                coordinate: CLLocationCoordinate2D(latitude: 52.63625, longitude: -1.133691)
            ),
            outcome: "A no further action disposal",
            outcomeLinkedToObjectOfSearch: nil,
            date: DateFormatter.dateTimeWithTimeZoneOffset.date(from: "2018-06-08T13:40:00+00:00")!
        )
    }

    static var mocks: [StopAndSearch] {
        [
            .mock,
            StopAndSearch(
                type: .vehicleSearch,
                didInvolvePerson: false,
                gender: .female,
                ageRange: "40 - 50",
                selfDefinedEthnicity: "White - English/Welsh/Scottish/Northern Irish/British",
                officerDefinedEthnicity: "White",
                legislation: "Police and Criminal Evidence Act 1984 (section 1)",
                objectOfSearch: "Offensive language",
                removalOfMoreThanOuterClothing: true,
                operationName: nil,
                location: Location(
                    street: Street(
                        id: 883_415,
                        name: "On or near Shopping Area"
                    ),
                    coordinate: CLLocationCoordinate2D(latitude: 52.63625, longitude: -1.133691)
                ),
                outcome: "A no further action disposal",
                outcomeLinkedToObjectOfSearch: nil,
                date: DateFormatter.dateTimeWithTimeZoneOffset.date(from: "2019-01-12T02:22:00+00:00")!
            )
        ]
    }

}
