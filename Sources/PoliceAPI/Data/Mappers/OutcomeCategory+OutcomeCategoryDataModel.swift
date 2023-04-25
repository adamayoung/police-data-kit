import Foundation

extension OutcomeCategory {

    init(dataModel: OutcomeCategoryDataModel) {
        self.init(
            id: dataModel.id,
            name: dataModel.name
        )
    }

}
