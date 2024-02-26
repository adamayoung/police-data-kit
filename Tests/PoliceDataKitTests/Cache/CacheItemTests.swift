//
//  CacheItemTests.swift
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

@testable import PoliceDataKit
import XCTest

final class CacheItemTests: XCTestCase {

    func testIsExpiredWhenNoExpiresInSetReturnsFalse() {
        let item = CacheItem(key: "key1", object: "object1")

        XCTAssertFalse(item.isExpired)
    }

    func testIsExpiredWhenNotExpiredReturnsFalse() {
        let item = CacheItem(key: "key2", object: "object3", expiresIn: 10)

        XCTAssertFalse(item.isExpired)
    }

    func testIsExpiredWhenExpiredReturnsTrue() {
        let item = CacheItem(key: "key3", object: "object3", expiresIn: -10)

        XCTAssertTrue(item.isExpired)
    }

}
