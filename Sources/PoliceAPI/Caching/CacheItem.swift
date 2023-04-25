import Foundation

final class CacheItem {

    let key: String
    let object: Any
    let expiresAt: Date?

    var isExpired: Bool {
        guard let expiresAt else {
            return false
        }

        return expiresAt.timeIntervalSinceNow < 0
    }

    init(key: String, object: Any, expiresIn: TimeInterval? = nil) {
        self.key = key
        self.object = object
        self.expiresAt = {
            guard let expiresIn else {
                return nil
            }

            return Date(timeIntervalSinceNow: expiresIn)
        }()
    }

}
