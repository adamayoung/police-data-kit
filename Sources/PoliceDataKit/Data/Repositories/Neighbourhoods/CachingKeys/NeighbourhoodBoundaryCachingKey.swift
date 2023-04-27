import Foundation

struct NeighbourhoodBoundaryCachingKey: CachingKey {

    let neighbourhoodID: NeighbourhoodDataModel.ID
    let policeForceID: PoliceForceDataModel.ID

    var keyValue: String {
        "neighbourhood-\(neighbourhoodID)-\(policeForceID)-boundary"
    }

    init(neighbourhoodID: NeighbourhoodDataModel.ID, policeForceID: PoliceForceDataModel.ID) {
        self.neighbourhoodID = neighbourhoodID
        self.policeForceID = policeForceID
    }

}
