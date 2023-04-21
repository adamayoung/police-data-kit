import Foundation

struct NeighbourhoodPrioritiesCachingKey: CachingKey {

    let neighbourhoodID: Neighbourhood.ID
    let policeForceID: PoliceForce.ID

    var keyValue: String {
        "neighbourhood-\(neighbourhoodID)-\(policeForceID)-priorities"
    }

    init(neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID) {
        self.neighbourhoodID = neighbourhoodID
        self.policeForceID = policeForceID
    }

}
