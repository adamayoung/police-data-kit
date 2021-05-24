import Foundation

public final class UKPoliceDataAPI: PoliceDataAPI {

    public static let shared: PoliceDataAPI = UKPoliceDataAPI()

    public let policeForces: PoliceForceService
    public let neighbourhoods: NeighbourhoodService
    public let crimes: CrimeService
    public let outcomes: OutcomeService
    public let stopAndSearches: StopAndSearchService
    public let availability: AvailabilityService

    init(
        policeForceService: PoliceForceService = UKPoliceForceService(),
        neighbourhoodService: NeighbourhoodService = UKNeighbourhoodService(),
        crimeService: CrimeService = UKCrimeService(),
        outcomes: OutcomeService = UKOutcomeService(),
        stopAndSearches: StopAndSearchService = UKStopAndSearchService(),
        availability: AvailabilityService = UKAvailabilityService()
    ) {
        self.policeForces = policeForceService
        self.neighbourhoods = neighbourhoodService
        self.crimes = crimeService
        self.outcomes = outcomes
        self.stopAndSearches = stopAndSearches
        self.availability = availability
    }

}
