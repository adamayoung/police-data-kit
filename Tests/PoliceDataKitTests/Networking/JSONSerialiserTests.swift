//
//  JSONSerialiserTests.swift
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

@Suite("JSONSerialiser")
struct JSONSerialiserTests {

    let serialiser: JSONSerialiser

    init() {
        self.serialiser = JSONSerialiser(decoder: JSONDecoder())
    }

    @Test("decode when data cannot be decoded throws decode error")
    func decodeWhenDataCannotBeDecodedThrowsDecodeError() {
        let data = Data("aaa".utf8)

        #expect(throws: (any Error).self) {
            try serialiser.decode(MockObject.self, from: data)
        }
    }

    @Test("decode when data can be decoded returns decoded object")
    func decodeWhenDataCanBeDecodedReturnsDecodedObject() throws {
        let expectedResult = MockObject()
        let data = expectedResult.data

        let result = try serialiser.decode(MockObject.self, from: data)

        #expect(result == expectedResult)
    }

}

extension JSONSerialiserTests {

    private struct MockObject: Codable, Equatable {

        let id: UUID

        var data: Data {
            // swiftlint:disable force_try
            try! JSONEncoder().encode(self)
            // swiftlint:enable force_try
        }

        init(id: UUID = .init()) {
            self.id = id
        }
    }

}
