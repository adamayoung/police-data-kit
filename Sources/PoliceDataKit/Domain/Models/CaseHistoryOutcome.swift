import Foundation

///
/// A model representing a case history outcome.
///
public struct CaseHistoryOutcome: Equatable {

    /// An identifier for the suspect/offender, where available.
    public let personID: String?

    /// Date (truncated to the year and month) of the crime.
    public let date: Date

    /// Category of the outcome.
    public let category: OutcomeCategory

    ///
    /// Creates a case history outcome object.
    ///
    /// - Parameters:
    ///   - personID: An identifier for the suspect/offender, where available.
    ///   - date: Month of the crime.
    ///   - category: Category of the outcome.
    ///   
    public init(personID: String? = nil, date: Date, category: OutcomeCategory) {
        self.personID = personID
        self.date = date
        self.category = category
    }

}
