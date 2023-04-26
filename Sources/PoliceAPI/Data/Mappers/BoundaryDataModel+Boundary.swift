import CoreLocation
import Foundation

extension BoundaryDataModel {

    init(coordinates: [CLLocationCoordinate2D]) {
        let coordinates = coordinates.map(CoordinateDataModel.init)

        self.init(coordinates)
    }

}
