import Foundation

/// UK Police Force Data.
public final class UKPoliceAPI {

    /// Police Force service.
    public let policeForces: PoliceForceService
    /// Neighbour service.
    public let neighbourhoods: NeighbourhoodService
    /// Crime service.
    public let crimes: CrimeService
    /// Outcome service.
    public let outcomes: OutcomeService
    /// Stop and Searches service.
    public let stopAndSearches: StopAndSearchService
    /// Data Availability service.
    public let availability: AvailabilityService

    /// Creates a new `UKPoliceAPI`.
    public convenience init() {
        self.init(baseURL: .policeDataAPIBaseURL, urlSessionConfiguration: .default)
    }

    convenience init(baseURL: URL, urlSessionConfiguration: URLSessionConfiguration) {
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        let serialiser = Serialiser(decoder: .policeDataAPI)
        let apiClient = PoliceDataAPIClient(baseURL: baseURL, urlSession: urlSession, serialiser: serialiser)
        let cache = InMemoryCache(name: "PoliceAPICache")
        let availableDataRegion = CoordinateRegion.availableDataRegion

        self.init(
            policeForceService: UKPoliceForceService(apiClient: apiClient, cache: cache),
            neighbourhoodService: UKNeighbourhoodService(apiClient: apiClient, cache: cache,
                                                         availableDataRegion: availableDataRegion),
            crimeService: UKCrimeService(apiClient: apiClient, cache: cache, availableDataRegion: availableDataRegion),
            outcomes: UKOutcomeService(apiClient: apiClient, cache: cache, availableDataRegion: availableDataRegion),
            stopAndSearches: UKStopAndSearchService(apiClient: apiClient, cache: cache,
                                                    availableDataRegion: availableDataRegion),
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
