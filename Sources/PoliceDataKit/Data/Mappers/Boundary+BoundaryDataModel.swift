import CoreLocation
import Foundation

extension Array<CLLocationCoordinate2D> {

    init(dataModel: BoundaryDataModel) {
        self.init(dataModel.map(CLLocationCoordinate2D.init))
    }

}
