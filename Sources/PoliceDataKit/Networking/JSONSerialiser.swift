import Foundation

actor JSONSerialiser: Serialiser {

    private let decoder: JSONDecoder

    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    func decode<T: Decodable>(_ type: T.Type, from data: Data) async throws -> T {
        let result = try decoder.decode(T.self, from: data)
        return result
    }

}
