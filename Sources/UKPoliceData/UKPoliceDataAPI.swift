import Foundation

public final class UKPoliceDataAPI: PoliceDataAPI {

    public static let shared: PoliceDataAPI = UKPoliceDataAPI()

    public let policeForces: PoliceForceService
    public let neighbourhoods: NeighbourhoodService

    init(
        policeForces: PoliceForceService = UKPoliceForceService(),
        neighbourhoods: NeighbourhoodService = UKNeighbourhoodService()
    ) {
        self.policeForces = policeForces
        self.neighbourhoods = neighbourhoods
    }

}
