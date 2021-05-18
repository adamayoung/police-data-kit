import Foundation

/// An outcome of a crime.
public struct Outcome: Decodable, Equatable {

    /// An identifier for the suspect/offender, where available.
    public let personID: String?
    /// Month of the crime.
    public let month: String
    /// Category of the outcome.
    public let category: OutcomeCategory
    /// Crime information.
    public let crime: OutcomeCrime

    /// Creates a a new `Outcome`.
    ///
    /// - Parameters:
    ///     - personID: An identifier for the suspect/offender, where available.
    ///     - month: Month of the crime.
    ///     - category: Category of the outcome.
    ///     - crime: Crime information.
    public init(personID: String? = nil, month: String, category: OutcomeCategory, crime: OutcomeCrime) {
        self.personID = personID
        self.month = month
        self.category = category
        self.crime = crime
    }

}

extension Outcome {

    private enum CodingKeys: String, CodingKey {
        case personID = "personId"
        case month = "date"
        case category
        case crime
    }

}
