import Foundation

/// A neighbourhood policing team responsible for a particular area.
public struct NeighbourhoodPolicingTeam: Decodable, Equatable {

    /// Unique force identifier.
    public let force: String
    /// Force specific team identifier.
    public let neighbourhood: String

    /// Creates a a new `NeighbourhoodPolicingTeam`.
    ///
    /// - Parameters:
    ///     - force: Unique force identifier.
    ///     - neighbourhood: Force specific team identifier.
    public init(force: String, neighbourhood: String) {
        self.force = force
        self.neighbourhood = neighbourhood
    }

}
