import Foundation

struct NeighbourhoodLocationDataModel: Decodable, Equatable {

    let name: String?
    let type: String?
    let description: String?
    let address: String
    let postcode: String?
    let latitude: String?
    let longitude: String?

    init(
        name: String? = nil,
        type: String? = nil,
        description: String? = nil,
        address: String,
        postcode: String? = nil,
        latitude: String? = nil,
        longitude: String? = nil
    ) {
        self.name = name
        self.type = type
        self.description = description
        self.address = address
        self.postcode = postcode
        self.latitude = latitude
        self.longitude = longitude
    }

}
