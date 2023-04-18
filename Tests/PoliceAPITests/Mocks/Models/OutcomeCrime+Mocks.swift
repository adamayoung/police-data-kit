import Foundation
@testable import PoliceAPI

extension OutcomeCrime {

    static var mock: OutcomeCrime {
        OutcomeCrime(
            id: 86783916,
            crimeID: "c69de56fd2fcd523ab65b588811caf53e7ff3a577b2bfd2f731173f5f95af99d",
            context: "",
            categoryID: "burglary",
            location: Location(
                street: Location.Street(
                    id: 884330,
                    name: "On or near Christow Street"
                ),
                coordinate: Coordinate(latitude: 52.640374, longitude: -1.122319)
            ),
            locationType: .force,
            locationSubtype: "ROAD",
            date: DateFormatter.yearMonth.date(from: "2020-09")!
        )
    }

}
