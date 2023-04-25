import Foundation
import PoliceAPIDomain

extension Location.Street {

    init(dataModel: LocationDataModel.Street) {
        self.init(
            id: dataModel.id,
            name: dataModel.name
        )
    }

}
