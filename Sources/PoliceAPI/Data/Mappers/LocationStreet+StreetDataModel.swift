import Foundation

extension Location.Street {

    init(dataModel: StreetDataModel) {
        self.init(
            id: dataModel.id,
            name: dataModel.name
        )
    }

}
