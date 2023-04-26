import CoreLocation
import Foundation

extension Array<CLLocationCoordinate2D> {

    init(dataModel: BoundaryDataModel) {
        let coordinates = dataModel.map(CLLocationCoordinate2D.init)

        self.init(coordinates)
    }

}
