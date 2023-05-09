import CoreLocation
import Foundation

///
/// A model representing a neighbourhood.
///
public struct Neighbourhood: Identifiable, Equatable, Codable {

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

    /// Center point locator for the neighbourhood.
    ///
    /// This may not be exactly in the center of the neighbourhood.
    public let center: CLLocationCoordinate2D

    /// Any associated locations with the neighbourhood.
    public let locations: [NeighbourhoodLocation]

    /// Links.
    public let links: [Link]

    ///
    /// Creates a neighbourhood object.
    ///
    /// - Parameters:
    ///   - id: Police Force specific team identifier.
    ///   - name: Name for the neighbourhood.
    ///   - description: Description.
    ///   - policeForceWebsiteURL: URL for the neighbourhood on the Force's website.
    ///   - welcomeMessage: An introduction message for the neighbourhood.
    ///   - population: Population of the neighbourhood.
    ///   - contactDetails: Ways to get in touch with the neighbourhood officers.
    ///   - center: Center point locator for the neighbourhood.
    ///   - locations: Any associated locations with the neighbourhood.
    ///   - links: Links.
    ///
    public init(
        id: String,
        name: String,
        description: String? = nil,
        policeForceWebsiteURL: URL? = nil,
        welcomeMessage: String? = nil,
        population: Int? = nil,
        contactDetails: ContactDetails = ContactDetails(),
        center: CLLocationCoordinate2D,
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
        self.center = center
        self.locations = locations
        self.links = links
    }

}

extension Neighbourhood {

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case policeForceWebsiteURL = "urlForce"
        case welcomeMessage
        case population
        case contactDetails
        case center = "centre"
        case locations
        case links
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.policeForceWebsiteURL = try container.decodeIfPresent(URL.self, forKey: .policeForceWebsiteURL)
        self.welcomeMessage = try container.decodeIfPresent(String.self, forKey: .welcomeMessage)
        self.population = try {
            let populationString = try container.decode(String.self, forKey: .population)

            guard let population = Int(populationString), population > 0 else {
                return nil
            }

            return population
        }()
        self.contactDetails = try container.decode(ContactDetails.self, forKey: .contactDetails)
        self.center = try container.decode(CLLocationCoordinate2D.self, forKey: .center)
        self.locations = try container.decode([NeighbourhoodLocation].self, forKey: .locations)
        self.links = try container.decode([Link].self, forKey: .links)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(policeForceWebsiteURL, forKey: .policeForceWebsiteURL)
        try container.encodeIfPresent(welcomeMessage, forKey: .welcomeMessage)
        let populationString: String? = {
            guard let population else {
                return nil
            }

            return String(population)
        }()
        try container.encodeIfPresent(populationString, forKey: .population)
        try container.encode(contactDetails, forKey: .contactDetails)
        try container.encode(center, forKey: .center)
        try container.encode(locations, forKey: .locations)
        try container.encode(links, forKey: .links)
    }

}
