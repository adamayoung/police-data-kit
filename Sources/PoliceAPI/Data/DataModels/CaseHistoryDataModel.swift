import Foundation

/// Case history for a crime.
struct CaseHistoryDataModel: Decodable, Equatable {

    /// Crime information.
    let crime: CaseHistoryCrimeDataModel
    /// Outcomes of the crime.
    let outcomes: [CaseHistoryOutcomeDataModel]

    /// Creates a new `CaseHistory`.
    ///
    /// - Parameters:
    ///   - crime: Crime information.
    ///   - outcomes: Outcomes of the crime.
    init(crime: CaseHistoryCrimeDataModel, outcomes: [CaseHistoryOutcomeDataModel]) {
        self.crime = crime
        self.outcomes = outcomes
    }

}
