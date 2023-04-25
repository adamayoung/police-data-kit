import Foundation

extension CrimeCategory {

    init(dataModel: CrimeCategoryDataModel) {
        self.init(
            id: dataModel.id,
            name: dataModel.name
        )
    }

}
