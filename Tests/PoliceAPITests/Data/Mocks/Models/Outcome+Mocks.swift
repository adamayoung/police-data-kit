import Foundation
@testable import PoliceAPI

extension OutcomeDataModel {

    static var mock: OutcomeDataModel {
        OutcomeDataModel(
            personID: nil,
            date: DateFormatter.yearMonth.date(from: "2020-09")!,
            category: .init(
                id: "no-further-action",
                name: "Investigation complete; no suspect identified"
            ),
            crime: .init(
                id: 86783916,
                crimeID: "c69de56fd2fcd523ab65b588811caf53e7ff3a577b2bfd2f731173f5f95af99d",
                context: "",
                categoryID: "burglary",
                location: .init(
                    street: .init(
                        id: 884330,
                        name: "On or near Christow Street"
                    ),
                    latitude: "52.640374",
                    longitude: "-1.122319"
                ),
                locationType: .force,
                locationSubtype: "ROAD",
                date: DateFormatter.yearMonth.date(from: "2020-09")!
            )
        )
    }

    static var mocks: [OutcomeDataModel] {
        [
            .mock,
            .init(
                personID: nil,
                date: DateFormatter.yearMonth.date(from: "2021-01")!,
                category: .init(
                    id: "incomplete",
                    name: "Investigation incomplete"
                ),
                crime: .init(
                    id: 86783932232,
                    crimeID: "hfd78fd89s078f9ds789fds789fdfdjnmlnm4432",
                    context: "",
                    categoryID: "theft",
                    location: .init(
                        street: .init(
                            id: 884330,
                            name: "On or near Christow Street"
                        ),
                        latitude: "52.640374",
                        longitude: "-1.122319"
                    ),
                    locationType: .force,
                    locationSubtype: "ROAD",
                    date: DateFormatter.yearMonth.date(from: "2021-01")!
                )
            )
        ]
    }

}
