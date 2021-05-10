import Foundation

public final class UKPoliceDataAPI: PoliceDataAPI {

    public static let shared: PoliceDataAPI = UKPoliceDataAPI()

    public let policeForces: PoliceForceService
    public let neighbourhoods: NeighbourhoodService
    public let crimes: CrimeService

    init(
        policeForceService: PoliceForceService = UKPoliceForceService(),
        neighbourhoodService: NeighbourhoodService = UKNeighbourhoodService(),
        crimeService: CrimeService = UKCrimeService()
    ) {
        self.policeForces = policeForceService
        self.neighbourhoods = neighbourhoodService
        self.crimes = crimeService
    }

}
