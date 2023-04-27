import Foundation

extension CaseHistoryOutcome {

    init(dataModel: CaseHistoryOutcomeDataModel) {
        let category = OutcomeCategory(dataModel: dataModel.category)

        self.init(
            personID: dataModel.personID,
            date: dataModel.date,
            category: category
        )
    }

}
