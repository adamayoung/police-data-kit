import Foundation

struct NeighbourhoodPolicingTeamDataModel: Decodable, Equatable {

    let force: String
    let neighbourhood: String

    init(force: String, neighbourhood: String) {
        self.force = force
        self.neighbourhood = neighbourhood
    }

}
