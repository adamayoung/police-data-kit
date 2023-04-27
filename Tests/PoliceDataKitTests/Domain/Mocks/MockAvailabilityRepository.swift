import Foundation
@testable import PoliceDataKit

final class MockAvailabilityRepository: AvailabilityRepository {

    var availableDataSetsResult: Result<[DataSet], Error> = .failure(AvailabilityError.unknown)

    init() { }

    func availableDataSets() async throws -> [DataSet] {
        try availableDataSetsResult.get()
    }

}
