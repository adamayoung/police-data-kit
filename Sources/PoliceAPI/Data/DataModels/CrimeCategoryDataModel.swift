import Foundation

struct CrimeCategoryDataModel: Identifiable, Decodable, Equatable {

    let id: String
    let name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}

extension CrimeCategoryDataModel {

    private enum CodingKeys: String, CodingKey {
        case id = "url"
        case name
    }

}
