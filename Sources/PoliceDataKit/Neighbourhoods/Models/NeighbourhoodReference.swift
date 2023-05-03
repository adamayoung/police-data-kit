import Foundation

///
/// A model representing a neighbourhood reference.
///
public struct NeighbourhoodReference: Identifiable, Equatable, Codable {

    /// Police Force specific team identifier.
    ///
    /// This identifier is not unique and may also be used by a different force.
    public let id: String

    /// Name for the neighbourhood.
    public let name: String

    ///
    /// Creates a neighbourhood reference object.
    ///
    /// - Parameters:
    ///   - id: Police Force specific team identifier.
    ///   - name: Name for the neighbourhood.
    ///
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}
