//
//  NeighbourhoodEvent+Mocks.swift
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
@testable import PoliceDataKit

extension NeighbourhoodEvent {

    static var mock: Self {
        NeighbourhoodEvent(
            title: "Sherwood Beat Surgery",
            type: "meeting",
            description: "Come meet your local team",
            address: "Sherwood Library, Nottingham",
            startDate: Date(timeIntervalSince1970: 1_474_128_000),
            endDate: Date(timeIntervalSince1970: 1_474_135_200)
        )
    }

    static var mocks: [Self] {
        [
            mock,
            NeighbourhoodEvent(
                title: "Community Forum",
                type: "forum",
                description: "Discuss local issues",
                address: nil,
                startDate: Date(timeIntervalSince1970: 1_475_661_600),
                endDate: nil
            )
        ]
    }

}
