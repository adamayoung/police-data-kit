import CoreLocation
import Foundation

extension Location {

    init(dataModel: LocationDataModel) {
        let street = Street(dataModel: dataModel.street)
        let latitude = Double(dataModel.latitude) ?? 0
        let longitude = Double(dataModel.longitude) ?? 0
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        self.init(
            street: street,
            coordinate: coordinate
        )
    }

}
