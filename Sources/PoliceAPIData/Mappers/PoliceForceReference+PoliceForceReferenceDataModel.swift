import Foundation
import PoliceAPIDomain

extension PoliceForceReference {

    init(dataModel: PoliceForceReferenceDataModel) {
        self.init(
            id: dataModel.id,
            name: dataModel.name
        )
    }

}
