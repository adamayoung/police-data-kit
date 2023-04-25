import Foundation
import PoliceAPIDomain

extension NeighbourhoodPolicingTeam {

    init(dataModel: NeighbourhoodPolicingTeamDataModel) {
        self.init(
            force: dataModel.force,
            neighbourhood: dataModel.neighbourhood
        )
    }

}
