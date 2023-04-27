import Foundation

/// Category of the outcome of a crime.
public struct OutcomeCategory: Identifiable, Equatable {

    /// Category code.
    public let id: String
    /// Name of the category.
    public let name: String

    /// Creates a new `OutcomeCategory`.
    ///
    /// - Parameters:
    ///   - id: Category code.
    ///   - name: Name of the category.
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}
