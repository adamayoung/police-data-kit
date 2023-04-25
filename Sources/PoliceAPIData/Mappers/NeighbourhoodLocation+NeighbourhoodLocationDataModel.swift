import Foundation
import PoliceAPIDomain

extension NeighbourhoodLocation {

    init(dataModel: NeighbourhoodLocationDataModel) {
        let coordinate: Coordinate? = {
            guard let coordinate = dataModel.coordinate else {
                return nil
            }

            return Coordinate(dataModel: coordinate)
        }()

        self.init(
            name: dataModel.name,
            type: dataModel.type,
            description: dataModel.description,
            address: dataModel.address,
            postcode: dataModel.postcode,
            coordinate: coordinate
        )
    }

}
