import Foundation

public final class FetchAvailableDataSets: FetchAvailableDataSetsUseCase {

    typealias FetchAvailabileDataSets = () async throws -> [DataSet]

    private let availableDataSets: FetchAvailabileDataSets

    public convenience init(provider: some AvailabilityRepositoryProviding) {
        self.init(availableDataSets: provider.availabilityRepository.availableDataSets)
    }

    init(availableDataSets: @escaping FetchAvailabileDataSets) {
        self.availableDataSets = availableDataSets
    }

    public func execute() async throws -> [DataSet] {
        let dataSets = try await availableDataSets()

        return dataSets
    }

}
