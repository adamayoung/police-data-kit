import Foundation
@testable import PoliceDataKit

extension OutcomeStatusDataModel {

    static var mock: Self {
        OutcomeStatusDataModel(
            category: "Investigation complete; no suspect identified",
            date: DateFormatter.yearMonth.date(from: "2020-02")!
        )
    }

}
