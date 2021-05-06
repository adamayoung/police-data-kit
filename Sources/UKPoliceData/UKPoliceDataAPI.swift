import Foundation

public final class UKPoliceDataAPI: PoliceDataAPI {

    public static let shared: PoliceDataAPI = UKPoliceDataAPI()

    public let policeForces: PoliceForceService

    init(
        policeForces: PoliceForceService = UKPoliceForceService()
    ) {
        self.policeForces = policeForces
    }

}
