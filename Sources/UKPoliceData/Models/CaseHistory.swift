import Foundation

/// Case history for a crime.
public struct CaseHistory: Decodable, Equatable {

    /// Crime information.
    public let crime: CaseHistoryCrime
    /// Outcomes of the crime.
    public let outcomes: [CaseHistoryOutcome]

    /// Creates a a new `CaseHistory`.
    ///
    /// - Parameters:
    ///     - crime: Crime information.
    ///     - outcomes: Outcomes of the crime.
    public init(crime: CaseHistoryCrime, outcomes: [CaseHistoryOutcome]) {
        self.crime = crime
        self.outcomes = outcomes
    }

}
