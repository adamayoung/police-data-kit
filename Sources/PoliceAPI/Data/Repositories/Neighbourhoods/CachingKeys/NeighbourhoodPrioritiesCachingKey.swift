import Foundation

struct NeighbourhoodPrioritiesCachingKey: CachingKey {

    let neighbourhoodID: NeighbourhoodDataModel.ID
    let policeForceID: PoliceForceDataModel.ID

    var keyValue: String {
        "neighbourhood-\(neighbourhoodID)-\(policeForceID)-priorities"
    }

    init(neighbourhoodID: NeighbourhoodDataModel.ID, policeForceID: PoliceForceDataModel.ID) {
        self.neighbourhoodID = neighbourhoodID
        self.policeForceID = policeForceID
    }

}
