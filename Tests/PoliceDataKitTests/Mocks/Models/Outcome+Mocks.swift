import CoreLocation
import Foundation
@testable import PoliceDataKit

extension Outcome {

    static var mock: Self {
        Outcome(
            personID: nil,
            date: DateFormatter.yearMonth.date(from: "2020-09")!,
            category: OutcomeCategory(
                id: "no-further-action",
                name: "Investigation complete; no suspect identified"
            ),
            crime: OutcomeCrime(
                id: 86783916,
                crimeID: "c69de56fd2fcd523ab65b588811caf53e7ff3a577b2bfd2f731173f5f95af99d",
                context: "",
                categoryID: "burglary",
                location: Location(
                    street: Street(
                        id: 884330,
                        name: "On or near Christow Street"
                    ),
                    coordinate: CLLocationCoordinate2D(latitude: 52.640374, longitude: -1.122319)
                ),
                locationType: .force,
                locationSubtype: "ROAD",
                date: DateFormatter.yearMonth.date(from: "2020-09")!
            )
        )
    }

    static var mocks: [Self] {
        [
            .mock,
            Outcome(
                personID: nil,
                date: DateFormatter.yearMonth.date(from: "2021-01")!,
                category: OutcomeCategory(
                    id: "incomplete",
                    name: "Investigation incomplete"
                ),
                crime: OutcomeCrime(
                    id: 86783932232,
                    crimeID: "hfd78fd89s078f9ds789fds789fdfdjnmlnm4432",
                    context: "",
                    categoryID: "theft",
                    location: Location(
                        street: Street(
                            id: 884330,
                            name: "On or near Christow Street"
                        ),
                        coordinate: CLLocationCoordinate2D(latitude: 52.640374, longitude: -1.122319)
                    ),
                    locationType: .force,
                    locationSubtype: "ROAD",
                    date: DateFormatter.yearMonth.date(from: "2021-01")!
                )
            )
        ]
    }

}
