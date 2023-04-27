import Foundation

struct StreetDataModel: Identifiable, Decodable, Equatable {

    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
