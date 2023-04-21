import Foundation

struct PoliceForceCachingKey: CachingKey {

    let id: PoliceForce.ID

    var keyValue: String {
        "police-force-\(id)"
    }

    init(id: PoliceForce.ID) {
        self.id = id
    }

}
