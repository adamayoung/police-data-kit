import Foundation
import UKPoliceData

extension Outcome {

    static var mock: Outcome {
        Outcome(
            personID: nil,
            month: "2020-09",
            category: OutcomeCategory(
                id: "no-further-action",
                name: "Investigation complete; no suspect identified"
            ),
            crime: OutcomeCrime(
                id: 86783916,
                persistentID: "c69de56fd2fcd523ab65b588811caf53e7ff3a577b2bfd2f731173f5f95af99d",
                context: "",
                categoryID: "burglary",
                location: CrimeLocation(
                    street: CrimeLocation.Street(
                        id: 884330,
                        name: "On or near Christow Street"
                    ),
                    latitude: 52.640374,
                    longitude: -1.122319
                ),
                locationType: .force,
                locationSubtype: "ROAD",
                month: "2020-09"
            )
        )
    }

    static var mocks: [Outcome] {
        [
            .mock,
            Outcome(
                personID: nil,
                month: "2021-01",
                category: OutcomeCategory(
                    id: "incomplete",
                    name: "Investigation incomplete"
                ),
                crime: OutcomeCrime(
                    id: 86783932232,
                    persistentID: "hfd78fd89s078f9ds789fds789fdfdjnmlnm4432",
                    context: "",
                    categoryID: "theft",
                    location: CrimeLocation(
                        street: CrimeLocation.Street(
                            id: 884330,
                            name: "On or near Christow Street"
                        ),
                        latitude: 52.640374,
                        longitude: -1.122319
                    ),
                    locationType: .force,
                    locationSubtype: "ROAD",
                    month: "2021-01"
                )
            )
        ]
    }

}