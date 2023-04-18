import Foundation
import PoliceAPI

extension CrimeCategory {

    static var mock: CrimeCategory {
        CrimeCategory(
            id: "anti-social-behaviour",
            name: "Anti-social behaviour"
        )
    }

    static var mocks: [CrimeCategory] {
        [
            .mock,
            CrimeCategory(
                id: "bicycle-theft",
                name: "Bicycle theft"
            ),
            CrimeCategory(
                id: "burglary",
                name: "Burglary"
            )
        ]
    }

}
