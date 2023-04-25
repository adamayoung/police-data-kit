import Foundation

/// UK Police Force Data.
public final class UKPoliceAPIProvider {

    public init() { }

}

extension UKPoliceAPIProvider: AvailabilityRepositoryProviding {

    var availabilityRepository: AvailabilityRepository {
        UKAvailabilityRepository(apiClient: Self.apiClient, cache: Self.cache)
    }

}

extension UKPoliceAPIProvider: CrimeRepositoryProviding {

    var crimeRepository: CrimeRepository {
        UKCrimeRepository(apiClient: Self.apiClient, cache: Self.cache, availableDataRegion: .availableDataRegion)
    }

}

extension UKPoliceAPIProvider: NeighbourhoodRepositoryProviding {

    var neighbourhoodRepository: NeighbourhoodRepository {
        UKNeighbourhoodRepository(
            apiClient: Self.apiClient,
            cache: Self.cache,
            availableDataRegion: .availableDataRegion
        )
    }

}

extension UKPoliceAPIProvider: OutcomeRepositoryProviding {

    var outcomeRepository: OutcomeRepository {
        UKOutcomeRepository(
            apiClient: Self.apiClient,
            cache: Self.cache,
            availableDataRegion: .availableDataRegion
        )
    }

}

extension UKPoliceAPIProvider: PoliceForceRepositoryProviding {

    var policeForceRepository: PoliceForceRepository {
        UKPoliceForceRepository(apiClient: Self.apiClient, cache: Self.cache)
    }

}

extension UKPoliceAPIProvider: StopAndSearchRepositoryProviding {

    var stopAndSearchRepository: StopAndSearchRepository {
        UKStopAndSearchRepository(
            apiClient: Self.apiClient,
            cache: Self.cache,
            availableDataRegion: .availableDataRegion
        )
    }

}

extension UKPoliceAPIProvider {

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
        InMemoryCache(name: "PoliceAPICache")
    }()

}
