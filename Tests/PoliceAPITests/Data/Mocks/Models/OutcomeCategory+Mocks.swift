import Foundation
@testable import PoliceAPI

extension OutcomeCategoryDataModel {

    static var mock: OutcomeCategoryDataModel {
        OutcomeCategoryDataModel(
            id: "no-further-action",
            name: "Investigation complete; no suspect identified"
        )
    }

}
