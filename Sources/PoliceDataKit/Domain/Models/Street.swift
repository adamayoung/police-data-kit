import Foundation

///
/// A model representing a street.
///
public struct Street: Identifiable, Equatable {

    /// Unique identifier for the street.
    public let id: Int

    /// Name of the location.
    public let name: String

    /// Creates a street object.
    ///
    /// - Parameters:
    ///   - id: Unique identifier for the street.
    ///   - name: Name of the approximate location.
    ///
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

}
