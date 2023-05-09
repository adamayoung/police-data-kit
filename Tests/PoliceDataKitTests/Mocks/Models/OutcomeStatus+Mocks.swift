import Foundation
@testable import PoliceDataKit

extension OutcomeStatus {

    static var mock: Self {
        OutcomeStatus(
            category: "Investigation complete; no suspect identified",
            date: DateFormatter.yearMonth.date(from: "2020-02")!
        )
    }

}
