import CoreLocation
import Foundation

extension CoordinateDataModel {

    init(coordinate: CLLocationCoordinate2D) {
        self.init(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
    }

}
