import Foundation
@testable import UKPoliceData

extension OutcomeStatus {

    static var mock: OutcomeStatus {
        OutcomeStatus(
            category: "Investigation complete; no suspect identified",
            date: DateFormatter.yearMonth.date(from: "2020-02")!
        )
    }

}
