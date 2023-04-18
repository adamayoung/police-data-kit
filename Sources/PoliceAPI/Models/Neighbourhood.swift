import Foundation

/// A Neighbourhood.
public struct Neighbourhood: Identifiable, Decodable, Equatable {

    /// Police Force specific team identifier.
    ///
    /// - Note: This identifier is not unique and may also be used by a different force.
    public let id: String
    /// Name for the neighbourhood.
    public var name: String {
        nameString.htmlStripped
    }
    /// Description.
    public var description: String? {
        descriptionString?.htmlStripped
    }
    /// URL for the neighbourhood on the Force's website.
    public let policeForceWebsite: URL
    /// An introduction message for the neighbourhood.
    public let welcomeMessage: String?
    /// Population of the neighbourhood.
    public var population: Int {
        Int(populationString) ?? 0
    }
    /// Ways to get in touch with the neighbourhood officers.
    public let contactDetails: ContactDetails
    /// Centre point locator for the neighbourhood.
    ///
    /// - Note: This may not be exactly in the centre of the neighbourhood.
    public let centre: Coordinate
    /// Any associated locations with the neighbourhood.
    ///
    /// - Note: e.g. police stations
    public let locations: [NeighbourhoodLocation]
    /// Links.
    public let links: [Link]

    private let nameString: String
    private let descriptionString: String?
    private let populationString: String

    /// Creates a a new `Neighbourhood`.
    ///
    /// - Parameters:
    ///     - id: Police Force specific team identifier.
    ///     - name: Name for the neighbourhood.
    ///     - description: Description.
    ///     - policeForceWebsite: URL for the neighbourhood on the Force's website.
    ///     - welcomeMessage: An introduction message for the neighbourhood.
    ///     - population: Population of the neighbourhood.
    ///     - contactDetails: Ways to get in touch with the neighbourhood officers.
    ///     - centre: Centre point locator for the neighbourhood.
    ///     - locations: Any associated locations with the neighbourhood.
    ///     - links: Links.
    public init(id: String, name: String, description: String? = nil, policeForceWebsite: URL,
                welcomeMessage: String? = nil, population: Int, contactDetails: ContactDetails = .init(),
                centre: Coordinate, locations: [NeighbourhoodLocation] = [], links: [Link] = []) {
        self.id = id
        self.nameString = name
        self.descriptionString = description
        self.policeForceWebsite = policeForceWebsite
        self.welcomeMessage = welcomeMessage
        self.populationString = String(population)
        self.contactDetails = contactDetails
        self.centre = centre
        self.locations = locations
        self.links = links
    }

}

extension Neighbourhood {

    private enum CodingKeys: String, CodingKey {
        case id
        case nameString = "name"
        case descriptionString = "description"
        case policeForceWebsite = "urlForce"
        case welcomeMessage
        case populationString = "population"
        case contactDetails
        case centre
        case locations
        case links
    }

}
