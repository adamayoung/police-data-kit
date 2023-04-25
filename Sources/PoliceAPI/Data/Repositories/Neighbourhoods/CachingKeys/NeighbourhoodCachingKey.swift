import Foundation

struct NeighbourhoodCachingKey: CachingKey {

    let id: NeighbourhoodDataModel.ID
    let policeForceID: PoliceForceDataModel.ID

    var keyValue: String {
        "neighbourhood-\(id)-\(policeForceID)"
    }

    init(id: NeighbourhoodDataModel.ID, policeForceID: PoliceForceDataModel.ID) {
        self.id = id
        self.policeForceID = policeForceID
    }

}
