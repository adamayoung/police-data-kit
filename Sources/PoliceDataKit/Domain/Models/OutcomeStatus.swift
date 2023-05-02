import Foundation

///
/// A model representing an outcome's status.
///
public struct OutcomeStatus: Equatable {

    /// Category of the outcome.
    public let category: String

    /// Date of the outcome.
    public let date: Date

    ///
    /// Creates an outcome status object.
    ///
    /// - Parameters:
    ///   - category: Category of the outcome.
    ///   - date: Date of the outcome.
    /// 
    public init(category: String, date: Date) {
        self.category = category
        self.date = date
    }

}
