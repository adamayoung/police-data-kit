//
//  EngagementMethodTests.swift
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

@Suite("EngagementMethod")
struct EngagementMethodTests {

    @Test("decode returns engagement method")
    func decodeReturnsEngagementMethod() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(EngagementMethod.self, fromResource: "engagement-method")

        #expect(result == .mock)
    }

    @Test("decode returns engagement method with u r l")
    func decodeReturnsEngagementMethodWithURL() throws {
        let engagementMethod = try JSONDecoder.policeDataAPI
            .decode(EngagementMethod.self, fromResource: "engagement-method")

        let result = engagementMethod.url

        #expect(result == EngagementMethod.mock.url)
    }

    @Test("decode returns engagement method with empty u r l")
    func decodeReturnsEngagementMethodWithEmptyURL() throws {
        let result = try JSONDecoder.policeDataAPI
            .decode(EngagementMethod.self, fromResource: "engagement-method-empty-url")

        #expect(result.url == nil)
    }

}
