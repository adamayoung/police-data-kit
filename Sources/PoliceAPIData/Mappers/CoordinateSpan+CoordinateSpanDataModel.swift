import Foundation
import PoliceAPIDomain

extension CoordinateSpan {

    init(dataModel: CoordinateSpanDataModel) {
        self.init(
            latitudeDelta: dataModel.latitudeDelta,
            longitudeDelta: dataModel.longitudeDelta
        )
    }

}
