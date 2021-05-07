import Foundation
import UKPoliceData

extension Coordinate {

    static var mock: Coordinate {
        Coordinate(
            latitude: 52.6389,
            longitude: -1.13619
        )
    }

    static var mocks: [Coordinate] {
        [
            Coordinate(
                latitude: 52.6394052587,
                longitude: -1.1458618876
            ),
            Coordinate(
                latitude: 52.6389452755,
                longitude: -1.1457057759
            ),
            Coordinate(
                latitude: 52.6383706746,
                longitude: -1.1455755443
            )
        ]
    }

}
