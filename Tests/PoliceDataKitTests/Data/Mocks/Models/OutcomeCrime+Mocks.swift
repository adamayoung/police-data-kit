import Foundation
@testable import PoliceDataKit

extension OutcomeCrimeDataModel {

    static var mock: Self {
        OutcomeCrimeDataModel(
            id: 86783916,
            crimeID: "c69de56fd2fcd523ab65b588811caf53e7ff3a577b2bfd2f731173f5f95af99d",
            context: "",
            categoryID: "burglary",
            location: LocationDataModel(
                street: StreetDataModel(
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
    }

}
