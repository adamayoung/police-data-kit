import Foundation

/// The category and date of an outcome for a crime.
public struct CrimeOutcomeStatus: Decodable, Equatable {

    /// Category of the outcome.
    public let category: String
    /// Date of the outcome.
    public let date: String

    public init(category: String, date: String) {
        self.category = category
        self.date = date
    }

}
