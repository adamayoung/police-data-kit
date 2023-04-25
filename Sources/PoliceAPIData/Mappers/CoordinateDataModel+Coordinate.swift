import Foundation
import PoliceAPIDomain

extension CoordinateDataModel {

    init(coordinate: Coordinate) {
        self.init(
            latitude: coordinate.latitude,
            longitude: coordinate.longitude
        )
    }

}
