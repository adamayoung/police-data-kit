import Foundation
import PoliceAPIDomain

extension DataSet {

    init(dataModel: DataSetDataModel) {
        self.init(
            date: dataModel.date,
            stopAndSearch: dataModel.stopAndSearch
        )
    }

}
