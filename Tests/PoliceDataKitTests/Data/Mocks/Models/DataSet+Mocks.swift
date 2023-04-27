import Foundation
@testable import PoliceAPI

extension DataSetDataModel {

    static var mock: Self {
        DataSetDataModel(
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
            DataSetDataModel(
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
