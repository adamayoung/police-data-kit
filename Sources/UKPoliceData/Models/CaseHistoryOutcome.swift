import Foundation

/// An outcome of a case history.
public struct CaseHistoryOutcome: Decodable, Equatable {

    /// An identifier for the suspect/offender, where available.
    public let personID: String?
    /// Month of the crime.
    public let month: String
    /// Category of the outcome.
    public let category: OutcomeCategory

    /// Creates a a new `CaseHistoryOutcome`.
    ///
    /// - Parameters:
    ///     - personID: An identifier for the suspect/offender, where available.
    ///     - month: Month of the crime.
    ///     - category: Category of the outcome.
    public init(personID: String? = nil, month: String, category: OutcomeCategory) {
        self.personID = personID
        self.month = month
        self.category = category
    }

}

extension CaseHistoryOutcome {

    private enum CodingKeys: String, CodingKey {
        case personID = "personId"
        case month = "date"
        case category
    }

}
