import Foundation
@testable import PoliceAPIData

extension CrimeCategoryDataModel {

    static var mock: CrimeCategoryDataModel {
        CrimeCategoryDataModel(
            id: "anti-social-behaviour",
            name: "Anti-social behaviour"
        )
    }

    static var mocks: [CrimeCategoryDataModel] {
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
