import Foundation

/// The category and date of an outcome for a crime.
public struct OutcomeStatus: Decodable, Equatable {

    /// Category of the outcome.
    public let category: String
    /// Date of the outcome.
    public let date: String

    /// Creates a a new `OutcomeStatus`.
    ///
    /// - Parameters:
    ///     - category: Category of the outcome.
    ///     - date: Date of the outcome.
    public init(category: String, date: String) {
        self.category = category
        self.date = date
    }

}
