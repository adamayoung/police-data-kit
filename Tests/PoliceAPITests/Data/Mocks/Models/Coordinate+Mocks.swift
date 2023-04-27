import Foundation
@testable import PoliceAPI

extension CoordinateDataModel {

    static var mock: CoordinateDataModel {
        CoordinateDataModel(
            latitude: "52.6389",
            longitude: "-1.13619"
        )
    }

    static var outsideAvailableDataRegion: CoordinateDataModel {
        CoordinateDataModel(
            latitude: "32.6389",
            longitude: "4.13619"
        )
    }

}
