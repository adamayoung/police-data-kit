import Foundation
import UKPoliceData

extension CrimeLocation {

    static var mock: CrimeLocation {
        CrimeLocation(
            street: Street(
                id: 883425,
                name: "On or near Peacock Lane"
            ),
            latitude: 52.633888,
            longitude: -1.138924
        )
    }

}
