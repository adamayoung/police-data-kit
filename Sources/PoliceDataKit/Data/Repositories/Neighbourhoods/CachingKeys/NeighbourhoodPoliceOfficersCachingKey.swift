import Foundation

struct NeighbourhoodPoliceOfficersCachingKey: CachingKey {

    let neighbourhoodID: NeighbourhoodDataModel.ID
    let policeForceID: PoliceForceDataModel.ID

    var keyValue: String {
        "neighbourhood-\(neighbourhoodID)-\(policeForceID)-police-officers"
    }

    init(neighbourhoodID: NeighbourhoodDataModel.ID, policeForceID: PoliceForceDataModel.ID) {
        self.neighbourhoodID = neighbourhoodID
        self.policeForceID = policeForceID
    }

}
