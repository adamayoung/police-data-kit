import Foundation

protocol Serialiser {

    func decode<T: Decodable>(_ type: T.Type, from data: Data) async throws -> T

}
