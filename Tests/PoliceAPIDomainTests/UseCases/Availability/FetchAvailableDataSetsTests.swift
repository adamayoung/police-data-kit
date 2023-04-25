@testable import PoliceAPIDomain
import XCTest

final class FetchAvailableDataSetsTests: XCTestCase {

    func testExecuteReturnsDataSets() async throws {
        let expectedResult = [
            DataSet(
                date: Date(),
                stopAndSearch: [
                    "police-force-1",
                    "police-force-2",
                    "police-force-3"
                ]
            )
        ]

        let useCase = FetchAvailableDataSets {
            expectedResult
        }

        let result = try await useCase.execute()

        XCTAssertEqual(result, expectedResult)
    }

}
