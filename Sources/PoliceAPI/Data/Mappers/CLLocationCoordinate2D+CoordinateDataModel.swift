import CoreLocation
import Foundation

extension CLLocationCoordinate2D {

    init(dataModel: CoordinateDataModel) {
        let latitude = Double(dataModel.latitude) ?? 0
        let longitude = Double(dataModel.longitude) ?? 0

        self.init(
            latitude: latitude,
            longitude: longitude
        )
    }

}
