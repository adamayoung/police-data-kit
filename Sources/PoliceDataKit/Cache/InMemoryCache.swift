//
//  InMemoryCache.swift
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
import os

final actor InMemoryCache: Cache {

    private let cache: NSCache<NSString, CacheItem>
    private let defaultExpiresIn: TimeInterval
    private let logger: Logger

    init(name: String, defaultExpiresIn: TimeInterval = 60 * 60 * 12, countLimit: Int = 0) {
        self.cache = NSCache()
        cache.name = name
        cache.countLimit = countLimit
        self.defaultExpiresIn = defaultExpiresIn
        self.logger = Logger(subsystem: Logger.policeDataKit, category: "\(name)InMemoryCache")
    }

    func object<ObjectType: Any>(for key: some CustomStringConvertible, type _: ObjectType.Type) async -> ObjectType? {
        let cacheKey = keyValue(for: key)

        guard let item = cache.object(forKey: cacheKey) else {
            logger.trace("MISS \(key.description)")
            return nil
        }

        guard !item.isExpired else {
            logger.trace("EXPIRED \(key.description)")
            cache.removeObject(forKey: cacheKey)
            return nil
        }

        logger.trace("HIT \(key.description)")
        return item.object as? ObjectType
    }

    func set(_ object: Any?, for key: some CustomStringConvertible, expiresIn: TimeInterval? = nil) async {
        let cacheKey = keyValue(for: key)

        guard let object else {
            cache.removeObject(forKey: cacheKey)
            logger.trace("REMOVE \(key.description)")
            return
        }

        let item = CacheItem(key: key.description, object: object, expiresIn: expiresIn ?? defaultExpiresIn)
        cache.setObject(item, forKey: cacheKey)
        logger.trace("ADD \(key.description)")
    }

    func removeAll() async {
        cache.removeAllObjects()
    }

}

extension InMemoryCache {

    private func keyValue(for key: some CustomStringConvertible) -> NSString {
        NSString(string: key.description)
    }

}
