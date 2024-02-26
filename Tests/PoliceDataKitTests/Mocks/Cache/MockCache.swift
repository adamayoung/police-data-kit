//
//  MockCache.swift
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

final actor MockCache: Cache {

    private var cacheStore: [String: Any]

    init(initialCacheStore: [String: Any] = [:]) {
        self.cacheStore = initialCacheStore
    }

    func object<ObjectType>(for key: some CustomStringConvertible, type _: ObjectType.Type) async -> ObjectType? {
        cacheStore[key.description] as? ObjectType
    }

    func set(_ object: Any?, for key: some CustomStringConvertible, expiresIn _: TimeInterval? = nil) async {
        guard let object else {
            cacheStore.removeValue(forKey: key.description)
            return
        }

        cacheStore[key.description] = object
    }

    func removeAll() async {
        Task {
            cacheStore.removeAll()
        }
    }

}
