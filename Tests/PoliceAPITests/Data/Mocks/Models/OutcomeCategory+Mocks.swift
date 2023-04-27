import Foundation
@testable import PoliceAPI

extension OutcomeCategoryDataModel {

    static var mock: Self {
        OutcomeCategoryDataModel(
            id: "no-further-action",
            name: "Investigation complete; no suspect identified"
        )
    }

}
