import Foundation

protocol CachingKey: CustomStringConvertible {

    var keyValue: String { get }

}

extension CachingKey {

    var description: String {
        keyValue
    }

}
