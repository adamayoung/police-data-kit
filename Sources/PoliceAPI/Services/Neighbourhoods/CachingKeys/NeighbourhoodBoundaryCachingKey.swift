import Foundation

struct NeighbourhoodBoundaryCachingKey: CachingKey {

    let neighbourhoodID: Neighbourhood.ID
    let policeForceID: PoliceForce.ID

    var keyValue: String {
        "neighbourhood-\(neighbourhoodID)-\(policeForceID)-boundary"
    }

    init(neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID) {
        self.neighbourhoodID = neighbourhoodID
        self.policeForceID = policeForceID
    }

}
