import Foundation

public final class UKPoliceAPI {

    public let policeForces: PoliceForceService
    public let neighbourhoods: NeighbourhoodService
    public let crimes: CrimeService
    public let outcomes: OutcomeService
    public let stopAndSearches: StopAndSearchService
    public let availability: AvailabilityService

    public convenience init() {
        self.init(baseURL: .policeDataAPIBaseURL, urlSessionConfiguration: .default)
    }

    convenience init(baseURL: URL, urlSessionConfiguration: URLSessionConfiguration) {
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        let serialiser = Serialiser(decoder: .policeDataAPI)
        let apiClient = PoliceDataAPIClient(baseURL: baseURL, urlSession: urlSession, serialiser: serialiser)
        let cache = InMemoryCache(name: "PoliceAPICache")

        self.init(
            policeForceService: UKPoliceForceService(apiClient: apiClient, cache: cache),
            neighbourhoodService: UKNeighbourhoodService(apiClient: apiClient, cache: cache),
            crimeService: UKCrimeService(apiClient: apiClient),
            outcomes: UKOutcomeService(apiClient: apiClient),
            stopAndSearches: UKStopAndSearchService(apiClient: apiClient),
            availability: UKAvailabilityService(apiClient: apiClient, cache: cache)
        )
    }

    init(
        policeForceService: PoliceForceService,
        neighbourhoodService: NeighbourhoodService,
        crimeService: CrimeService,
        outcomes: OutcomeService,
        stopAndSearches: StopAndSearchService,
        availability: AvailabilityService
    ) {
        self.policeForces = policeForceService
        self.neighbourhoods = neighbourhoodService
        self.crimes = crimeService
        self.outcomes = outcomes
        self.stopAndSearches = stopAndSearches
        self.availability = availability
    }

}
