import Foundation

protocol Cache {

    func object<ObjectType: Any>(for key: some CustomStringConvertible, type: ObjectType.Type) async -> ObjectType?

    func set(_ object: Any?, for key: some CustomStringConvertible, expiresIn: TimeInterval?) async

    func removeAll() async

}

extension Cache {

    func set(_ object: Any?, for key: some CustomStringConvertible) async {
        await set(object, for: key, expiresIn: nil)
    }

}
