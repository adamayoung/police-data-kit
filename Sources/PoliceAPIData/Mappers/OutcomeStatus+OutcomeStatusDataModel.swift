import Foundation
import PoliceAPIDomain

extension OutcomeStatus {

    init(dataModel: OutcomeStatusDataModel) {
        self.init(
            category: dataModel.category,
            date: dataModel.date
        )
    }

}
