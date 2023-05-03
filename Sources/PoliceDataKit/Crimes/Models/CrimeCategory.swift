import Foundation

public struct CrimeCategory: Identifiable, Decodable, Equatable {

    public let id: String
    public let name: String

    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}

extension CrimeCategory {

    private enum CodingKeys: String, CodingKey {
        case id = "url"
        case name
    }

}
