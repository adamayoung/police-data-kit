import Foundation
import PoliceAPI

extension Location {

    static var mock: Location {
        Location(
            street: Street(
                id: 883425,
                name: "On or near Peacock Lane"
            ),
            coordinate: Coordinate(latitude: 52.633888, longitude: -1.138924)
        )
    }

}
