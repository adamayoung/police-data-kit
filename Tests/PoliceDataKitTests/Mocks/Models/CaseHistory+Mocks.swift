import Foundation
@testable import PoliceDataKit

extension CaseHistory {

    static var mock: Self {
        CaseHistory(
            crime: CaseHistoryCrime(
                id: 82067369,
                crimeID: "46688f40815e3a4cb7fcf69550492d8bffa4ed267652e676e49e23d00955c486",
                context: "",
                categoryID: "bicycle-theft",
                location: nil,
                locationType: nil,
                locationSubtype: "",
                date: DateFormatter.yearMonth.date(from: "2020-03")!
            ),
            outcomes: [
                CaseHistoryOutcome(
                    personID: nil,
                    date: DateFormatter.yearMonth.date(from: "2020-03")!,
                    category: OutcomeCategory(
                        id: "under-investigation",
                        name: "Under investigation"
                    )
                ),
                CaseHistoryOutcome(
                    personID: nil,
                    date: DateFormatter.yearMonth.date(from: "2020-03")!,
                    category: OutcomeCategory(
                        id: "no-further-action",
                        name: "Investigation complete; no suspect identified"
                    )
                )
            ]
        )
    }

}
