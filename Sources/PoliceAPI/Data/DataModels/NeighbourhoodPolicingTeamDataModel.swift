import Foundation

/// A Police Force's Neighbourhood.
struct NeighbourhoodPolicingTeamDataModel: Decodable, Equatable {

    /// Unique force identifier.
    let force: String
    /// Force specific team identifier.
    let neighbourhood: String

    /// Creates a new `NeighbourhoodPolicingTeam`.
    ///
    /// - Parameters:
    ///   - force: Unique force identifier.
    ///   - neighbourhood: Force specific team identifier.
    init(force: String, neighbourhood: String) {
        self.force = force
        self.neighbourhood = neighbourhood
    }

}
