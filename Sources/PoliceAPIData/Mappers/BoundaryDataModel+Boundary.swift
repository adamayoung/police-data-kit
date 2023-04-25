import Foundation
import PoliceAPIDomain

extension BoundaryDataModel {

    init(boundary: Boundary) {
        let coordinates = boundary.map(CoordinateDataModel.init)

        self.init(coordinates)
    }

}
