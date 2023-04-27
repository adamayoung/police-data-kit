import Foundation

final class PoliceDataKitFactory {

    private init() { }

    static func availabilityRepository() -> some AvailabilityRepository {
        UKAvailabilityRepository(apiClient: apiClient, cache: cache)
    }

    static func crimeRepository() -> some CrimeRepository {
        UKCrimeRepository(apiClient: apiClient, cache: cache, availableDataRegion: .availableDataRegion)
    }

    static func neighbourhoodRepository() -> some NeighbourhoodRepository {
        UKNeighbourhoodRepository(apiClient: apiClient, cache: cache, availableDataRegion: .availableDataRegion)
    }

    static func outcomeRepository() -> some OutcomeRepository {
        UKOutcomeRepository(apiClient: apiClient, cache: cache, availableDataRegion: .availableDataRegion)
    }

    static func policeForceRepository() -> some PoliceForceRepository {
        UKPoliceForceRepository(apiClient: apiClient, cache: cache)
    }

    static func stopAndSearchRepository() -> some StopAndSearchRepository {
        UKStopAndSearchRepository(apiClient: apiClient, cache: cache, availableDataRegion: .availableDataRegion)
    }

}

extension PoliceDataKitFactory {

    private static let apiClient: some APIClient = {
        PoliceDataAPIClient(
            baseURL: .policeDataAPIBaseURL,
            urlSession: .shared,
            serialiser: serialiser
        )
    }()

    private static var serialiser: some Serialiser {
        JSONSerialiser(decoder: .policeDataAPI)
    }

    private static let cache: some Cache = {
        InMemoryCache(name: "PoliceDataKitCache")
    }()

}
