import Foundation
@testable import PoliceDataKit

extension CrimeDataModel {

    static var mock: Self {
        CrimeDataModel(
            id: 81012437,
            crimeID: "0e51b9ceb4aedef3f9679481aa11262a6c5ea90a68d0dd0e0002a0b521c445e0",
            context: "",
            categoryID: "violent-crime",
            location: LocationDataModel(
                street: StreetDataModel(
                    id: 883345,
                    name: "On or near Marquis Street"
                ),
                latitude: "52.629909",
                longitude: "-1.132073"
            ),
            locationType: .force,
            locationSubtype: "",
            date: DateFormatter.yearMonth.date(from: "2020-02")!,
            outcomeStatus: OutcomeStatusDataModel(
                category: "Status update unavailable",
                date: DateFormatter.yearMonth.date(from: "2020-06")!
            )
        )
    }

    static var mocks: [Self] {
        [
            .mock,
            CrimeDataModel(
                id: 90362519,
                crimeID: "5d512591e5dc9dd264a08c8dc133c3dde5c843d329928d1e6124bfe8fc9216a5",
                context: "",
                categoryID: "criminal-damage-arson",
                location: LocationDataModel(
                    street: StreetDataModel(
                        id: 886204,
                        name: "On or near Ostlers Drive"
                    ),
                    latitude: "52.679277",
                    longitude: "-0.740683"
                ),
                locationType: .force,
                locationSubtype: "",
                date: DateFormatter.yearMonth.date(from: "2020-02")!,
                outcomeStatus: OutcomeStatusDataModel(
                    category: "Investigation complete; no suspect identified",
                    date: DateFormatter.yearMonth.date(from: "2021-02")!
                )
            )
        ]
    }

}
