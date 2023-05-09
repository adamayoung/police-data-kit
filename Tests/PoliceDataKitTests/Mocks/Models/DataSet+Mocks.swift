import Foundation
@testable import PoliceDataKit

extension DataSet {

    static var mock: Self {
        DataSet(
            date: DateFormatter.yearMonth.date(from: "2015-06")!,
            stopAndSearch: [
                "bedfordshire",
                "cleveland",
                "durham"
            ]
        )
    }

    static var mocks: [Self] {
        [
            .mock,
            DataSet(
                date: DateFormatter.yearMonth.date(from: "2015-05")!,
                stopAndSearch: [
                    "bedfordshire",
                    "city-of-london",
                    "cleveland"
                ]
            )
        ]
    }

}
