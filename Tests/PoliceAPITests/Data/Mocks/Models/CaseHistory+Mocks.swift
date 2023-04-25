import Foundation
@testable import PoliceAPI

extension CaseHistoryDataModel {

    static var mock: CaseHistoryDataModel {
        CaseHistoryDataModel(
            crime: CaseHistoryCrimeDataModel(
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
                CaseHistoryOutcomeDataModel(
                    personID: nil,
                    date: DateFormatter.yearMonth.date(from: "2020-03")!,
                    category: OutcomeCategoryDataModel(
                        id: "under-investigation",
                        name: "Under investigation"
                    )
                ),
                CaseHistoryOutcomeDataModel(
                    personID: nil,
                    date: DateFormatter.yearMonth.date(from: "2020-03")!,
                    category: OutcomeCategoryDataModel(
                        id: "no-further-action",
                        name: "Investigation complete; no suspect identified"
                    )
                )
            ]
        )
    }

}
