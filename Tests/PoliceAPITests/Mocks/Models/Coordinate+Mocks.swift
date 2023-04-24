import Foundation
import PoliceAPI

extension Coordinate {

    static var mock: Coordinate {
        Coordinate(
            latitude: 52.6389,
            longitude: -1.13619
        )
    }

    static var outsideAvailableDataRegion: Coordinate {
        Coordinate(
            latitude: 32.6389,
            longitude: 4.13619
        )
    }

}
