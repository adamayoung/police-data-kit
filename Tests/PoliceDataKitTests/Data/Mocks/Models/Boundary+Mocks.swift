import Foundation
@testable import PoliceAPI

extension BoundaryDataModel {

    static var mock: Self {
        [
            CoordinateDataModel(
                latitude: "52.6394052587",
                longitude: "-1.1458618876"
            ),
            CoordinateDataModel(
                latitude: "52.6389452755",
                longitude: "-1.1457057759"
            ),
            CoordinateDataModel(
                latitude: "52.6383706746",
                longitude: "-1.1455755443"
            )
        ]
    }

}
