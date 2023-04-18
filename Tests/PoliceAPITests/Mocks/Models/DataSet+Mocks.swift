import Foundation
@testable import PoliceAPI

extension DataSet {

    static var mock: DataSet {
        DataSet(
            date: DateFormatter.yearMonth.date(from: "2015-06")!,
            stopAndSearch: [
                "bedfordshire",
                "cleveland",
                "durham"
            ]
        )
    }

    static var mocks: [DataSet] {
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
