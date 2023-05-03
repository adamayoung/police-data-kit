import Foundation

struct NeighbourhoodPoliceOfficersCachingKey: CachingKey {

    let neighbourhoodID: Neighbourhood.ID
    let policeForceID: PoliceForce.ID

    var keyValue: String {
        "neighbourhood-\(neighbourhoodID)-\(policeForceID)-police-officers"
    }

    init(neighbourhoodID: Neighbourhood.ID, policeForceID: PoliceForce.ID) {
        self.neighbourhoodID = neighbourhoodID
        self.policeForceID = policeForceID
    }

}
