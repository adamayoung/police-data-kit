import Foundation

extension DataSet {

    init(dataModel: DataSetDataModel) {
        self.init(
            date: dataModel.date,
            stopAndSearch: dataModel.stopAndSearch
        )
    }

}
