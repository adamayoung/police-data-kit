import Foundation

///
/// A model representing contact details.
///
public struct ContactDetails: Equatable, Codable {

    /// Email address.
    public let email: String?

    /// Telephone number.
    public let telephone: String?

    /// Mobile number.
    public let mobile: String?

    /// Fax number.
    public let fax: String?

    /// Website address.
    public let web: URL?

    /// Street address.
    public let address: String?

    /// Facebook profile URL.
    public let facebook: URL?

    /// Twitter profile URL.
    public let twitter: URL?

    /// YouTube profile URL.
    public let youtube: URL?

    /// Myspace profile URL.
    public let myspace: URL?

    /// Bebo profile URL.
    public let bebo: URL?

    /// Flickr profile URL.
    public let flickr: URL?

    /// Forum URL.
    public let forum: URL?

    /// Blog URL.
    public let blog: URL?

    /// RSS URL.
    public let rss: URL?

    ///
    /// Creates a contact details object.
    ///
    /// - Parameters:
    ///   - email: Email address.
    ///   - telephone: Telephone number.
    ///   - mobile: Mobile number.
    ///   - fax: Fax number.
    ///   - web: Website address.
    ///   - address: Facebook profile URL.
    ///   - facebook: Facebook profile URL.
    ///   - twitter: Twitter profile URL.
    ///   - youtube: YouTube profile URL.
    ///   - myspace: Myspace profile URL.
    ///   - bebo: Bebo profile URL.
    ///   - flickr: Flickr profile URL.
    ///   - forum: Forum URL.
    ///   - blog: Blog URL.
    ///   - rss: RSS URL.
    ///
    public init(
        email: String? = nil,
        telephone: String? = nil,
        mobile: String? = nil,
        fax: String? = nil,
        web: URL? = nil,
        address: String? = nil,
        facebook: URL? = nil,
        twitter: URL? = nil,
        youtube: URL? = nil,
        myspace: URL? = nil,
        bebo: URL? = nil,
        flickr: URL? = nil,
        forum: URL? = nil,
        blog: URL? = nil,
        rss: URL? = nil
    ) {
        self.email = email
        self.telephone = telephone
        self.mobile = mobile
        self.fax = fax
        self.web = web
        self.address = address
        self.facebook = facebook
        self.twitter = twitter
        self.youtube = youtube
        self.myspace = myspace
        self.bebo = bebo
        self.flickr = flickr
        self.forum = forum
        self.blog = blog
        self.rss = rss
    }

}
