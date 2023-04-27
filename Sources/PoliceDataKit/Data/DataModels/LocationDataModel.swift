import Foundation

struct LocationDataModel: Decodable, Equatable {

    let street: StreetDataModel
    let latitude: String
    let longitude: String

    init(street: StreetDataModel, latitude: String, longitude: String) {
        self.street = street
        self.latitude = latitude
        self.longitude = longitude
    }

}
