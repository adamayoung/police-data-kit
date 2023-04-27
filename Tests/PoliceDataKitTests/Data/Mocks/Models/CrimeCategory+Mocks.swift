import Foundation
@testable import PoliceAPI

extension CrimeCategoryDataModel {

    static var mock: Self {
        CrimeCategoryDataModel(
            id: "anti-social-behaviour",
            name: "Anti-social behaviour"
        )
    }

    static var mocks: [Self] {
        [
            .mock,
            CrimeCategoryDataModel(
                id: "bicycle-theft",
                name: "Bicycle theft"
            ),
            CrimeCategoryDataModel(
                id: "burglary",
                name: "Burglary"
            )
        ]
    }

}
