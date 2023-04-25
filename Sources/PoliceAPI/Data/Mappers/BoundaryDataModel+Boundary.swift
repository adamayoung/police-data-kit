import Foundation

extension BoundaryDataModel {

    init(boundary: Boundary) {
        let coordinates = boundary.map(CoordinateDataModel.init)

        self.init(coordinates)
    }

}
