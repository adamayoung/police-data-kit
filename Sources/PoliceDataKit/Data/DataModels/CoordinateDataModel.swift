import Foundation

struct CoordinateDataModel: Decodable, Equatable, CustomStringConvertible {

    var latitude: String
    var longitude: String

    init(latitude: String, longitude: String) {
        self.latitude = latitude
        self.longitude = longitude
    }

    var description: String {
        "(\(latitude), \(longitude))"
    }

}
