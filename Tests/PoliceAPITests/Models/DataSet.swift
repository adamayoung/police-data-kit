@testable import PoliceAPI
import XCTest

final class DataSetTests: XCTestCase {

    func testDecodeReturnsDataSet() throws {
        let result = try JSONDecoder.policeDataAPI.decode(DataSet.self, fromResource: "data-set")

        XCTAssertEqual(result, .mock)
    }

    func testSortReturnsSortedDataSets() throws {
        let dataSet1 = DataSet(
            date: try XCTUnwrap(DateFormatter.yearMonth.date(from: "2019-05")),
            stopAndSearch: [
                "bedfordshire",
                "cleveland"
            ]
        )
        let dataSet2 = DataSet(
            date: try XCTUnwrap(DateFormatter.yearMonth.date(from: "2021-03")),
            stopAndSearch: [
                "city-of-london",
                "leicestershire"
            ]
        )
        let expectedResult = [dataSet1, dataSet2]

        let result = [dataSet2, dataSet1].sorted()

        XCTAssertEqual(result, expectedResult)
    }

}
