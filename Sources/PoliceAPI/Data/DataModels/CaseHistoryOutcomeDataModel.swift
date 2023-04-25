import Foundation

/// An outcome of a case history.
struct CaseHistoryOutcomeDataModel: Decodable, Equatable {

    /// An identifier for the suspect/offender, where available.
    let personID: String?
    /// Date (truncated to the year and month) of the crime.
    let date: Date
    /// Category of the outcome.
    let category: OutcomeCategoryDataModel

    /// Creates a new `CaseHistoryOutcome`.
    ///
    /// - Parameters:
    ///   - personID: An identifier for the suspect/offender, where available.
    ///   - date: Month of the crime.
    ///   - category: Category of the outcome.
    init(personID: String? = nil, date: Date, category: OutcomeCategoryDataModel) {
        self.personID = personID
        self.date = date
        self.category = category
    }

}

extension CaseHistoryOutcomeDataModel {

    private enum CodingKeys: String, CodingKey {
        case personID = "personId"
        case date
        case category
    }

}
