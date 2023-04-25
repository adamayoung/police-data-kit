import Foundation

public actor JSONSerialiser: Serialiser {

    private let decoder: JSONDecoder

    public init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    public func decode<T: Decodable>(_ data: Data) async throws -> T {
        let result = try decoder.decode(T.self, from: data)
        return result
    }

}
