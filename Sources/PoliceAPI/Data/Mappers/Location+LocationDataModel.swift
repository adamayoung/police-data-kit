import CoreLocation
import Foundation

extension Location {

    init(dataModel: LocationDataModel) {
        let street = Location.Street(dataModel: dataModel.street)
        let coordinate = CLLocationCoordinate2D(dataModel: dataModel.coordinate)

        self.init(
            street: street,
            coordinate: coordinate
        )
    }

}
