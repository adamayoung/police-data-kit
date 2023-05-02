import Foundation

///
/// A model representing a neighbourhood police team.
///
public struct NeighbourhoodPolicingTeam: Equatable {

    /// Unique force identifier.
    public let force: String

    /// Force specific team identifier.
    public let neighbourhood: String

    ///
    /// Creates a neighbourhood police team object.
    ///
    /// - Parameters:
    ///   - force: Unique force identifier.
    ///   - neighbourhood: Force specific team identifier.
    ///   
    public init(force: String, neighbourhood: String) {
        self.force = force
        self.neighbourhood = neighbourhood
    }

}
