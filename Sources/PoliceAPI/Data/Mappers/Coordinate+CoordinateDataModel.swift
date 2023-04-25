import Foundation

extension Coordinate {

    init(dataModel: CoordinateDataModel) {
        self.init(
            latitude: dataModel.latitude,
            longitude: dataModel.longitude
        )
    }

}
