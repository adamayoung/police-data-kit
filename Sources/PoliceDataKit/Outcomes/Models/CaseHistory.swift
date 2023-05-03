import Foundation

///
/// A model representing case history of a crime.
///
public struct CaseHistory: Equatable, Codable {

    /// Crime information.
    public let crime: CaseHistoryCrime

    /// Outcomes of the crime.
    public let outcomes: [CaseHistoryOutcome]

    ///
    /// Creates a case history object.
    ///
    /// - Parameters:
    ///   - crime: Crime information.
    ///   - outcomes: Outcomes of the crime.
    ///
    public init(crime: CaseHistoryCrime, outcomes: [CaseHistoryOutcome]) {
        self.crime = crime
        self.outcomes = outcomes
    }

}
