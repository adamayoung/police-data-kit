//
//  NeighbourhoodReference+Mocks.swift
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

extension NeighbourhoodReference {

    static var mock: Self {
        NeighbourhoodReference(
            id: "NC04",
            name: "City Centre"
        )
    }

    static var mocks: [Self] {
        [
            .mock,
            NeighbourhoodReference(
                id: "NC66",
                name: "Cultural Quarter"
            ),
            NeighbourhoodReference(
                id: "NC67",
                name: "Riverside"
            ),
            NeighbourhoodReference(
                id: "NC68",
                name: "Clarendon Park"
            )
        ]
    }

}
