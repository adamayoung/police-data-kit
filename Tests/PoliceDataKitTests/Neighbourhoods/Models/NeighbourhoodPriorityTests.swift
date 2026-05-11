//
//  NeighbourhoodPriorityTests.swift
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
import Testing

@Suite("NeighbourhoodPriority")
struct NeighbourhoodPriorityTests {

    @Test("decode returns neighbourhood priority")
    func decodeReturnsNeighbourhoodPriority() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriority.self, fromResource: "neighbourhood-priority")

        #expect(result == .mock)
    }

    @Test("decode when not action returns neighbourhood priority")
    func decodeWhenNotActionReturnsNeighbourhoodPriority() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(NeighbourhoodPriority.self, fromResource: "neighbourhood-priority-no-action")

        #expect(result == .mockNoAction)
    }

}
