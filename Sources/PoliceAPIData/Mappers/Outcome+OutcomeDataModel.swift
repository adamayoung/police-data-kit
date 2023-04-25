import Foundation
import PoliceAPIDomain

extension Outcome {

    init(dataModel: OutcomeDataModel) {
        let category = OutcomeCategory(dataModel: dataModel.category)
        let crime = OutcomeCrime(dataModel: dataModel.crime)

        self.init(
            personID: dataModel.personID,
            date: dataModel.date,
            category: category,
            crime: crime
        )
    }

}
