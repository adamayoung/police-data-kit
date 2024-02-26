//
//  InMemoryCacheTests.swift
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

final class InMemoryCacheTests: XCTestCase {

    var cache: InMemoryCache!

    override func setUp() {
        super.setUp()
        cache = InMemoryCache(name: "Test")
    }

    override func tearDown() {
        cache = nil
        super.tearDown()
    }

    func testEmptyCacheReturnsNil() async {
        let key = "test1"

        let object = await cache.object(for: key, type: String.self)

        XCTAssertNil(object)
    }

    func testEmptyCacheWhenSetObjectReturnsObject() async {
        let key = "test2"
        let object = "SomeCacheItem"

        await cache.set(object, for: key)
        let cachedObject = await cache.object(for: key, type: String.self)

        XCTAssertEqual(cachedObject, object)
    }

    func testCacheContainsObjectWithKeyWhenSetNewObjectWithSameKeyReturnsNewObject() async {
        let key = "test3"
        let oldObject = "OldCacheItem"
        let newObject = "NewCacheItem"

        await cache.set(oldObject, for: key)
        await cache.set(newObject, for: key)
        let cachedObject = await cache.object(for: key, type: String.self)

        XCTAssertEqual(cachedObject, newObject)
    }

    func testCacheContainsObjectWithKeyWhenSetNilWithSameKeyReturnsNil() async {
        let key = "test4"
        let oldObject = "OldCacheItem"

        await cache.set(oldObject, for: key)
        await cache.set(nil, for: key)
        let cachedObject = await cache.object(for: key, type: String.self)

        XCTAssertNil(cachedObject)
    }

    func testCacheContainsExpiredObjectReturnsNil() async {
        let key = "test5"
        let object = "ExpiredObject"

        await cache.set(object, for: key, expiresIn: 0)
        let cachedObject = await cache.object(for: key, type: String.self)

        XCTAssertNil(cachedObject)
    }

    func testRemoveAll() async {
        let key1 = "key1"
        let key2 = "key2"
        let key3 = "key3"
        await cache.set("object1", for: key1)
        await cache.set("object2", for: key2)
        await cache.set("object3", for: key3)

        await cache.removeAll()

        let cachedObject1 = await cache.object(for: key1, type: String.self)
        let cachedObject2 = await cache.object(for: key2, type: String.self)
        let cachedObject3 = await cache.object(for: key3, type: String.self)

        XCTAssertNil(cachedObject1)
        XCTAssertNil(cachedObject2)
        XCTAssertNil(cachedObject3)
    }

}
