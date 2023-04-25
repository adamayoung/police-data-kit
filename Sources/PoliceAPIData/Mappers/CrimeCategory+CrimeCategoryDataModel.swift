import Foundation
import PoliceAPIDomain

extension CrimeCategory {

    init(dataModel: CrimeCategoryDataModel) {
        self.init(
            id: dataModel.id,
            name: dataModel.name
        )
    }

}
