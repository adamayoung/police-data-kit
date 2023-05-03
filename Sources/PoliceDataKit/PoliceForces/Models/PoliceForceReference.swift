import Foundation

///
/// A model representing a reference to a police force.
///
public struct PoliceForceReference: Identifiable, Equatable, Codable {

    /// Unique police force identifier.
    public let id: String

    /// Police force name.
    public let name: String

    ///
    /// Creates a police force reference object.
    ///
    /// - Parameters:
    ///   - id: Unique police force identifier.
    ///   - name: Police force name.
    ///
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}
