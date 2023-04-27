import CoreLocation
import Foundation

extension NeighbourhoodLocation {

    init(dataModel: NeighbourhoodLocationDataModel) {
        let coordinate: CLLocationCoordinate2D? = {
            guard
                let latitudeString = dataModel.latitude,
                let latitude = Double(latitudeString),
                let longitudeString = dataModel.longitude,
                let longitude = Double(longitudeString)
            else {
                return nil
            }

            return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }()

        self.init(
            name: dataModel.name,
            type: dataModel.type,
            description: dataModel.description,
            address: dataModel.address,
            postcode: dataModel.postcode,
            coordinate: coordinate
        )
    }

}
