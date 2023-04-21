import Foundation

struct NeighbourhoodCachingKey: CachingKey {

    let id: Neighbourhood.ID
    let policeForceID: PoliceForce.ID

    var keyValue: String {
        "neighbourhood-\(id)-\(policeForceID)"
    }

    init(id: Neighbourhood.ID, policeForceID: PoliceForce.ID) {
        self.id = id
        self.policeForceID = policeForceID
    }

}
