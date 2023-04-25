import Foundation
@testable import PoliceAPI

extension DataSetDataModel {

    static var mock: DataSetDataModel {
        DataSetDataModel(
            date: DateFormatter.yearMonth.date(from: "2015-06")!,
            stopAndSearch: [
                "bedfordshire",
                "cleveland",
                "durham"
            ]
        )
    }

    static var mocks: [DataSetDataModel] {
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
