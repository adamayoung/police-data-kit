import Foundation

/// A Neighbourhood.
struct NeighbourhoodDataModel: Identifiable, Decodable, Equatable {

    /// Police Force specific team identifier.
    ///
    /// This identifier is not unique and may also be used by a different force.
    let id: String
    /// Name for the neighbourhood.
    var name: String {
        nameString.htmlStripped
    }
    /// Description.
    var description: String? {
        descriptionString?.htmlStripped
    }
    /// URL for the neighbourhood on the Force's website.
    var policeForceWebsite: URL? {
        guard let policeForceWebsiteString else {
            return nil
        }

        return URL(string: policeForceWebsiteString)
    }
    /// An introduction message for the neighbourhood.
    let welcomeMessage: String?
    /// Population of the neighbourhood.
    var population: Int {
        Int(populationString) ?? 0
    }
    /// Ways to get in touch with the neighbourhood officers.
    let contactDetails: ContactDetailsDataModel
    /// Centre point locator for the neighbourhood.
    ///
    /// This may not be exactly in the centre of the neighbourhood.
    let centre: CoordinateDataModel
    /// Any associated locations with the neighbourhood.
    ///
    /// e.g. police stations
    let locations: [NeighbourhoodLocationDataModel]
    /// Links.
    let links: [LinkDataModel]

    private let policeForceWebsiteString: String?
    private let nameString: String
    private let descriptionString: String?
    private let populationString: String

    /// Creates a new `Neighbourhood`.
    ///
    /// - Parameters:
    ///   - id: Police Force specific team identifier.
    ///   - name: Name for the neighbourhood.
    ///   - description: Description.
    ///   - policeForceWebsite: URL for the neighbourhood on the Force's website.
    ///   - welcomeMessage: An introduction message for the neighbourhood.
    ///   - population: Population of the neighbourhood.
    ///   - contactDetails: Ways to get in touch with the neighbourhood officers.
    ///   - centre: Centre point locator for the neighbourhood.
    ///   - locations: Any associated locations with the neighbourhood.
    ///   - links: Links.
    init(
        id: String,
        name: String,
        description: String? = nil,
        policeForceWebsite: URL? = nil,
        welcomeMessage: String? = nil,
        population: Int,
        contactDetails: ContactDetailsDataModel = .init(),
        centre: CoordinateDataModel,
        locations: [NeighbourhoodLocationDataModel] = [],
        links: [LinkDataModel] = []
    ) {
        self.id = id
        self.nameString = name
        self.descriptionString = description
        self.policeForceWebsiteString = policeForceWebsite?.absoluteString
        self.welcomeMessage = welcomeMessage
        self.populationString = String(population)
        self.contactDetails = contactDetails
        self.centre = centre
        self.locations = locations
        self.links = links
    }

}

extension NeighbourhoodDataModel {

    private enum CodingKeys: String, CodingKey {
        case id
        case nameString = "name"
        case descriptionString = "description"
        case policeForceWebsiteString = "urlForce"
        case welcomeMessage
        case populationString = "population"
        case contactDetails
        case centre
        case locations
        case links
    }

}
