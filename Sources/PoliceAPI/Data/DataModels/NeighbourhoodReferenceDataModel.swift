import Foundation

/// A Neighbourhood reference.
struct NeighbourhoodReferenceDataModel: Identifiable, Decodable, Equatable {

    /// Police Force specific team identifier.
    ///
    /// This identifier is not unique and may also be used by a different force.
    let id: String
    /// Name for the neighbourhood.
    let name: String

    /// Creates a new `NeighbourhoodReference`.
    ///
    /// - Parameters:
    ///   - id: Police Force specific team identifier.
    ///   - name: Name for the neighbourhood.
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}
