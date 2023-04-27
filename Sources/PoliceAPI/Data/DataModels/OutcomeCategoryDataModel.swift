import Foundation

struct OutcomeCategoryDataModel: Identifiable, Decodable, Equatable {

    let id: String
    let name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

}

extension OutcomeCategoryDataModel {

    private enum CodingKeys: String, CodingKey {
        case id = "code"
        case name
    }

}
