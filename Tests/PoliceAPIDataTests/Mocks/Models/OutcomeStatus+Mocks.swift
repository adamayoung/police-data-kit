import Foundation
@testable import PoliceAPIData

extension OutcomeStatusDataModel {

    static var mock: OutcomeStatusDataModel {
        OutcomeStatusDataModel(
            category: "Investigation complete; no suspect identified",
            date: DateFormatter.yearMonth.date(from: "2020-02")!
        )
    }

}
