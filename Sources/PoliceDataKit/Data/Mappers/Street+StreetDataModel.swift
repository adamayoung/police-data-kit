import Foundation

extension Street {

    init(dataModel: StreetDataModel) {
        self.init(
            id: dataModel.id,
            name: dataModel.name
        )
    }

}
