import Foundation

struct PoliceForceDataModel: Identifiable, Decodable, Equatable {

    let id: String
    let name: String
    let description: String?
    let telephone: String
    let url: URL
    let engagementMethods: [EngagementMethodDataModel]

    init(
        id: String,
        name: String,
        description: String? = nil,
        telephone: String,
        url: URL,
        engagementMethods: [EngagementMethodDataModel] = []
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.telephone = telephone
        self.url = url
        self.engagementMethods = engagementMethods
    }

}
