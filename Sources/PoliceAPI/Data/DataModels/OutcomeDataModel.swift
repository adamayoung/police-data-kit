import Foundation

/// An outcome of a crime.
struct OutcomeDataModel: Decodable, Equatable {

    /// An identifier for the suspect/offender, where available.
    let personID: String?
    /// Date (truncated to the year and month) of the crime.
    let date: Date
    /// Category of the outcome.
    let category: OutcomeCategoryDataModel
    /// Crime information.
    let crime: OutcomeCrimeDataModel

    /// Creates a new `Outcome`.
    ///
    /// - Parameters:
    ///   - personID: An identifier for the suspect/offender, where available.
    ///   - date: Date of the crime.
    ///   - category: Category of the outcome.
    ///   - crime: Crime information.
    init(
        personID: String? = nil,
        date: Date,
        category: OutcomeCategoryDataModel,
        crime: OutcomeCrimeDataModel
    ) {
        self.personID = personID
        self.date = date
        self.category = category
        self.crime = crime
    }

}

extension OutcomeDataModel {

    private enum CodingKeys: String, CodingKey {
        case personID = "personId"
        case date
        case category
        case crime
    }

}
