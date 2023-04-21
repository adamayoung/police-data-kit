import Foundation

struct NeighbourhoodBoundaryCachingKey: CachingKey {

    let neighbourhoodID: Neighbourhood.ID
    let policeForceID: PoliceForce.ID

    var keyValue: String {
        "neighbourhood-boundary-\(neighbourhoodID)-\(policeForceID)"
    }

    init(neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID) {
        self.neighbourhoodID = neighbourhoodID
        self.policeForceID = policeForceID
    }

}
