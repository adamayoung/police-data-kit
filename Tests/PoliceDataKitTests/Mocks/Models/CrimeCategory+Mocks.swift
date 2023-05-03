import Foundation
@testable import PoliceDataKit

extension CrimeCategory {

    static var mock: Self {
        CrimeCategory(
            id: "anti-social-behaviour",
            name: "Anti-social behaviour"
        )
    }

    static var mocks: [Self] {
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
