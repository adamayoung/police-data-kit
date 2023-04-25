import Caching
import Foundation
import Networking
import PoliceAPIData
import PoliceAPIDomain

public final class UKPoliceAPIProvider {

    public init() { }

}

extension UKPoliceAPIProvider: AvailabilityRepositoryProviding {

    public var availabilityRepository: AvailabilityRepository {
        UKAvailabilityRepository(apiClient: Self.apiClient, cache: Self.cache)
    }

}

extension UKPoliceAPIProvider: CrimeRepositoryProviding {

    public var crimeRepository: CrimeRepository {
        UKCrimeRepository(apiClient: Self.apiClient, cache: Self.cache)
    }

}

extension UKPoliceAPIProvider: NeighbourhoodRepositoryProviding {

    public var neighbourhoodRepository: NeighbourhoodRepository {
        UKNeighbourhoodRepository(apiClient: Self.apiClient, cache: Self.cache)
    }

}

extension UKPoliceAPIProvider: OutcomeRepositoryProviding {

    public var outcomeRepository: OutcomeRepository {
        UKOutcomeRepository(apiClient: Self.apiClient, cache: Self.cache)
    }

}

extension UKPoliceAPIProvider: PoliceForceRepositoryProviding {

    public var policeForceRepository: PoliceForceRepository {
        UKPoliceForceRepository(apiClient: Self.apiClient, cache: Self.cache)
    }

}

extension UKPoliceAPIProvider: StopAndSearchRepositoryProviding {

    public var stopAndSearchRepository: StopAndSearchRepository {
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
