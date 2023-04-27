import Foundation

extension PoliceForceReference {

    init(dataModel: PoliceForceReferenceDataModel) {
        self.init(
            id: dataModel.id,
            name: dataModel.name
        )
    }

}
