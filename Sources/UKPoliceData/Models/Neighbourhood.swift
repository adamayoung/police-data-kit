import Foundation

/// A Neighbourhood.
public struct Neighbourhood: Identifiable, Decodable, Equatable {

    /// Police Force specific team identifier.
    ///
    /// - Note: This identifier is not unique and may also be used by a different force.
    public let id: String
    /// Name for the neighbourhood.
    public let name: String
    /// Description.
    public let description: String?
    /// URL for the neighbourhood on the Force's website.
    public let urlForce: URL
    /// An introduction message for the neighbourhood.
    public let welcomeMessage: String?
    /// Population of the neighbourhood.
    public let population: String
    /// Ways to get in touch with the neighbourhood officers.
    public let contactDetails: ContactDetails
    /// Centre point locator for the neighbourhood.
    ///
    /// - Note: This may not be exactly in the centre of the neighbourhood.
    public let centre: Coordinate
    /// Any associated locations with the neighbourhood.
    ///
    /// - Note: e.g. police stations
    public let locations: [Location]
    /// Links.
    public let links: [Link]

    public init(id: String, name: String, description: String? = nil, urlForce: URL, welcomeMessage: String? = nil,
                population: String, contactDetails: ContactDetails, centre: Coordinate, locations: [Location],
                links: [Link]) {
        self.id = id
        self.name = name
        self.description = description
        self.urlForce = urlForce
        self.welcomeMessage = welcomeMessage
        self.population = population
        self.contactDetails = contactDetails
        self.centre = centre
        self.locations = locations
        self.links = links
    }

}
