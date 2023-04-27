import Foundation
@testable import PoliceAPI

final actor MockCache: Cache {

    private var cacheStore: [String: Any]

    init(initialCacheStore: [String: Any] = [:]) {
        self.cacheStore = initialCacheStore
    }

    func object<ObjectType>(for key: some CustomStringConvertible, type: ObjectType.Type) async -> ObjectType? {
        cacheStore[key.description] as? ObjectType
    }

    func set(_ object: Any?, for key: some CustomStringConvertible, expiresIn: TimeInterval? = nil) async {
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
