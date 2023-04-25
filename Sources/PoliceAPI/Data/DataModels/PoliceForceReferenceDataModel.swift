import Foundation

/// A Police Force reference.
struct PoliceForceReferenceDataModel: Identifiable, Decodable, Equatable {

    /// Unique Police Force identifier.
    let id: String
    /// Police Force name.
    let name: String

    /// Creates a new `PoliceForceReference`.
    ///
    /// - Parameters:
    ///   - id: Unique Police Force identifier.
    ///   - name: Police Force name.
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}
