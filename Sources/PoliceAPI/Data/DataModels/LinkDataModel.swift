import Foundation

struct LinkDataModel: Decodable, Equatable {

    let title: String
    let description: String?
    var url: String?

    init(title: String, description: String? = nil, url: String? = nil) {
        self.title = title
        self.description = description
        self.url = url
    }

}
