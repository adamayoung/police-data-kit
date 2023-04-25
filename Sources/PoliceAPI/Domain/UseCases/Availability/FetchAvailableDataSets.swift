import Foundation

public final class FetchAvailableDataSets: FetchAvailableDataSetsUseCase {

    private let availableDataSets: () async throws -> [DataSet]

    public convenience init(provider: AvailabilityRepositoryProviding) {
        self.init(availableDataSets: provider.availabilityRepository.availableDataSets)
    }

    init(availableDataSets: @escaping () async throws -> [DataSet]) {
        self.availableDataSets = availableDataSets
    }

    public func execute() async throws -> [DataSet] {
        let dataSets = try await availableDataSets()

        return dataSets
    }

}
