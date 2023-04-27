import Foundation
@testable import PoliceDataKit

extension LocationDataModel {

    static var mock: Self {
        LocationDataModel(
            street: StreetDataModel(
                id: 883425,
                name: "On or near Peacock Lane"
            ),
            latitude: "52.633888",
            longitude: "-1.138924"
        )
    }

}
