import Foundation

/// A Neighbourhood reference.
public struct NeighbourhoodReference: Identifiable, Decodable, Equatable {

    /// Police Force specific team identifier.
    ///
    /// - Note: This identifier is not unique and may also be used by a different force.
    public let id: String
    /// Name for the neighbourhood.
    public let name: String

    /// Creates a new `NeighbourhoodReference`.
    ///
    /// - Parameters:
    ///   - id: Police Force specific team identifier.
    ///   - name: Name for the neighbourhood.
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}
