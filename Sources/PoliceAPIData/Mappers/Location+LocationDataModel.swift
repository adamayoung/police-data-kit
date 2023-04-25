import Foundation
import PoliceAPIDomain

extension Location {

    init(dataModel: LocationDataModel) {
        let street = Location.Street(dataModel: dataModel.street)
        let coordinate = Coordinate(dataModel: dataModel.coordinate)

        self.init(
            street: street,
            coordinate: coordinate
        )
    }

}
