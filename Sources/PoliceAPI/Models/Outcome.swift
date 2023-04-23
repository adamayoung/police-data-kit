import Foundation

/// An outcome of a crime.
public struct Outcome: Decodable, Equatable {

    /// An identifier for the suspect/offender, where available.
    public let personID: String?
    /// Date (truncated to the year and month) of the crime.
    public let date: Date
    /// Category of the outcome.
    public let category: OutcomeCategory
    /// Crime information.
    public let crime: OutcomeCrime

    /// Creates a new `Outcome`.
    ///
    /// - Parameters:
    ///   - personID: An identifier for the suspect/offender, where available.
    ///   - date: Date of the crime.
    ///   - category: Category of the outcome.
    ///   - crime: Crime information.
    public init(
        personID: String? = nil,
        date: Date,
        category: OutcomeCategory,
        crime: OutcomeCrime
    ) {
        self.personID = personID
        self.date = date
        self.category = category
        self.crime = crime
    }

}

extension Outcome {

    private enum CodingKeys: String, CodingKey {
        case personID = "personId"
        case date
        case category
        case crime
    }

}
