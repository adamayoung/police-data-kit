import Foundation
import PoliceAPIDomain

extension Boundary {

    init(dataModel: BoundaryDataModel) {
        let coordinates = dataModel.map(Coordinate.init)

        self.init(coordinates)
    }

}
