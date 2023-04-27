import Foundation

struct NeighbourhoodDataModel: Identifiable, Decodable, Equatable {

    let id: String
    let name: String
    let description: String?
    let policeForceWebsite: String?
    let welcomeMessage: String?
    let population: String
    let contactDetails: ContactDetailsDataModel
    let centre: CoordinateDataModel
    let locations: [NeighbourhoodLocationDataModel]
    let links: [LinkDataModel]

    init(
        id: String,
        name: String,
        description: String? = nil,
        policeForceWebsite: String? = nil,
        welcomeMessage: String? = nil,
        population: String,
        contactDetails: ContactDetailsDataModel = .init(),
        centre: CoordinateDataModel,
        locations: [NeighbourhoodLocationDataModel] = [],
        links: [LinkDataModel] = []
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.policeForceWebsite = policeForceWebsite
        self.welcomeMessage = welcomeMessage
        self.population = population
        self.contactDetails = contactDetails
        self.centre = centre
        self.locations = locations
        self.links = links
    }

}

extension NeighbourhoodDataModel {

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case policeForceWebsite = "urlForce"
        case welcomeMessage
        case population
        case contactDetails
        case centre
        case locations
        case links
    }

}
