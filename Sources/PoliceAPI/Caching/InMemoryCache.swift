import Foundation
import os

final actor InMemoryCache: NSObject, Cache {

    private let cache: NSCache<NSString, CacheItem>
    private let defaultExpiresIn: TimeInterval
    private let logger: Logger

    init(name: String, defaultExpiresIn: TimeInterval = 60 * 60 * 12, countLimit: Int = 0) {
        self.cache = NSCache()
        self.cache.name = name
        self.cache.countLimit = countLimit
        self.defaultExpiresIn = defaultExpiresIn
        self.logger = Logger(subsystem: Logger.cacheSubsystem, category: "\(name)InMemoryCache")
        super.init()
    }

    func object<ObjectType: Any>(for key: some CustomStringConvertible, type: ObjectType.Type) async -> ObjectType? {
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
