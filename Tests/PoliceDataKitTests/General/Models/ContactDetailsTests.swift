//
//  ContactDetailsTests.swift
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

@Suite("Contact details")
struct ContactDetailsTests {

    @Test("decode returns contact details")
    func decodeReturnsContactDetails() throws {
        let result = try JSONDecoder.policeDataAPI.decode(ContactDetails.self, fromResource: "contact-details")

        #expect(result == .mock)
    }

    @Test("decode when no items returns contact details")
    func decodeWhenNoItemsReturnsContactDetails() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(ContactDetails.self, fromResource: "contact-details-none")

        #expect(result == .mockNone)
    }

}
