import Foundation
import PoliceAPIDomain

extension NeighbourhoodReference {

    init(dataModel: NeighbourhoodReferenceDataModel) {
        self.init(
            id: dataModel.id,
            name: dataModel.name
        )
    }

}
