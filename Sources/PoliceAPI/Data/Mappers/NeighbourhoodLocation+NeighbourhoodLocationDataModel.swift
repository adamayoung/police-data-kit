import CoreLocation
import Foundation

extension NeighbourhoodLocation {

    init(dataModel: NeighbourhoodLocationDataModel) {
        let coordinate: CLLocationCoordinate2D? = {
            guard let coordinate = dataModel.coordinate else {
                return nil
            }

            return CLLocationCoordinate2D(dataModel: coordinate)
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
