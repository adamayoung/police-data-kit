import Foundation

public final class UKPoliceAPIProvider {

    public init() { }

}

extension UKPoliceAPIProvider: AvailabilityRepositoryProviding {

    public var availabilityRepository: any AvailabilityRepository {
        UKAvailabilityRepository(apiClient: Self.apiClient, cache: Self.cache)
    }

}

extension UKPoliceAPIProvider: CrimeRepositoryProviding {

    public var crimeRepository: any CrimeRepository {
        UKCrimeRepository(apiClient: Self.apiClient, cache: Self.cache)
    }

}

extension UKPoliceAPIProvider: NeighbourhoodRepositoryProviding {

    public var neighbourhoodRepository: any NeighbourhoodRepository {
        UKNeighbourhoodRepository(apiClient: Self.apiClient, cache: Self.cache)
    }

}

extension UKPoliceAPIProvider: OutcomeRepositoryProviding {

    public var outcomeRepository: any OutcomeRepository {
        UKOutcomeRepository(apiClient: Self.apiClient, cache: Self.cache)
    }

}

extension UKPoliceAPIProvider: PoliceForceRepositoryProviding {

    public var policeForceRepository: any PoliceForceRepository {
        UKPoliceForceRepository(apiClient: Self.apiClient, cache: Self.cache)
    }

}

extension UKPoliceAPIProvider: StopAndSearchRepositoryProviding {

    public var stopAndSearchRepository: any StopAndSearchRepository {
        UKStopAndSearchRepository(apiClient: Self.apiClient, cache: Self.cache)
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
