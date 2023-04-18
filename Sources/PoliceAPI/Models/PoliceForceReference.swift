import Foundation

/// A Police Force reference.
public struct PoliceForceReference: Identifiable, Decodable, Equatable {

    /// Unique Police Force identifier.
    public let id: String
    /// Police Force name.
    public let name: String

    /// Creates a a new `PoliceForceReference`.
    ///
    /// - Parameters:
    ///     - id: Unique Police Force identifier.
    ///     - name: Police Force name.
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}
