import Foundation

protocol Serialiser {

    func decode<T: Decodable>(_ data: Data) async throws -> T

}
