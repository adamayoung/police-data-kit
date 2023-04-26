import CoreLocation
import Foundation

extension CLLocationCoordinate2D {

    init(dataModel: CoordinateDataModel) {
        self.init(
            latitude: dataModel.latitude,
            longitude: dataModel.longitude
        )
    }

}
