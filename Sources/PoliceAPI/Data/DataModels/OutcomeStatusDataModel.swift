import Foundation

/// The category and date of an outcome for a crime.
struct OutcomeStatusDataModel: Decodable, Equatable {

    /// Category of the outcome.
    let category: String
    /// Date of the outcome.
    let date: Date

    /// Creates a new `OutcomeStatus`.
    ///
    /// - Parameters:
    ///   - category: Category of the outcome.
    ///   - date: Date of the outcome.
    init(category: String, date: Date) {
        self.category = category
        self.date = date
    }

}
