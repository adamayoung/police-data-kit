import CoreLocation
import Foundation

extension CoordinateDataModel {

    init(coordinate: CLLocationCoordinate2D) {
        let latitude = String(coordinate.latitude)
        let longitude = String(coordinate.longitude)

        self.init(
            latitude: latitude,
            longitude: longitude
        )
    }

}
