import Foundation
import PoliceAPIDomain

extension CaseHistory {

    init(dataModel: CaseHistoryDataModel) {
        let crime = CaseHistoryCrime(dataModel: dataModel.crime)
        let outcomes = dataModel.outcomes.map(CaseHistoryOutcome.init)

        self.init(
            crime: crime,
            outcomes: outcomes
        )
    }

}
