import Foundation
@testable import PoliceAPIData

extension LocationDataModel {

    static var mock: LocationDataModel {
        LocationDataModel(
            street: Street(
                id: 883425,
                name: "On or near Peacock Lane"
            ),
            coordinate: CoordinateDataModel(latitude: 52.633888, longitude: -1.138924)
        )
    }

}
