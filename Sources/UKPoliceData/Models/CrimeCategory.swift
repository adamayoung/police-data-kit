import Foundation

/// A crime category.
public struct CrimeCategory: Identifiable, Decodable, Equatable {

    /// Unique identifier.
    public let id: String
    /// Name of the crime category.
    public let name: String

    /// Creates a a new `CrimeCategory`.
    ///
    /// - Parameters:
    ///     - id: Unique identifier.
    ///     - name: Name of the crime category.
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
