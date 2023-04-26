import CoreLocation
import Foundation

/// A Neighbourhood.
public struct Neighbourhood: Identifiable, Equatable {

    /// Police Force specific team identifier.
    ///
    /// This identifier is not unique and may also be used by a different force.
    public let id: String
    /// Name for the neighbourhood.
    public var name: String
    /// Description.
    public var description: String?
    /// URL for the neighbourhood on the Force's website.
    public var policeForceWebsiteURL: URL?
    /// An introduction message for the neighbourhood.
    public let welcomeMessage: String?
    /// Population of the neighbourhood.
    public var population: Int?
    /// Ways to get in touch with the neighbourhood officers.
    public let contactDetails: ContactDetails
    /// Centre point locator for the neighbourhood.
    ///
    /// This may not be exactly in the centre of the neighbourhood.
    public let centre: CLLocationCoordinate2D
    /// Any associated locations with the neighbourhood.
    public let locations: [NeighbourhoodLocation]
    /// Links.
    public let links: [Link]

    /// Creates a new `Neighbourhood`.
    ///
    /// - Parameters:
    ///   - id: Police Force specific team identifier.
    ///   - name: Name for the neighbourhood.
    ///   - description: Description.
    ///   - policeForceWebsiteURL: URL for the neighbourhood on the Force's website.
    ///   - welcomeMessage: An introduction message for the neighbourhood.
    ///   - population: Population of the neighbourhood.
    ///   - contactDetails: Ways to get in touch with the neighbourhood officers.
    ///   - centre: Centre point locator for the neighbourhood.
    ///   - locations: Any associated locations with the neighbourhood.
    ///   - links: Links.
    public init(
        id: String,
        name: String,
        description: String? = nil,
        policeForceWebsiteURL: URL? = nil,
        welcomeMessage: String? = nil,
        population: Int? = nil,
        contactDetails: ContactDetails = .init(),
        centre: CLLocationCoordinate2D,
        locations: [NeighbourhoodLocation] = [],
        links: [Link] = []
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.policeForceWebsiteURL = policeForceWebsiteURL
        self.welcomeMessage = welcomeMessage
        self.population = population
        self.contactDetails = contactDetails
        self.centre = centre
        self.locations = locations
        self.links = links
    }

}
