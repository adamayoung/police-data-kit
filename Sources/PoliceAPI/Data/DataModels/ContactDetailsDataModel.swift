import Foundation

/// Contact details.
struct ContactDetailsDataModel: Decodable, Equatable {

    /// Email address.
    let email: String?
    /// Telephone number.
    let telephone: String?
    /// Mobile number.
    let mobile: String?
    /// Fax number.
    let fax: String?
    /// Website address.
    let web: URL?
    /// Street address.
    let address: String?
    /// Facebook profile URL.
    let facebook: URL?
    /// Twitter profile URL.
    let twitter: URL?
    /// YouTube profile URL.
    let youtube: URL?
    /// Myspace profile URL.
    let myspace: URL?
    /// Bebo profile URL.
    let bebo: URL?
    /// Flickr profile URL.
    let flickr: URL?
    /// Forum URL.
    let forum: URL?
    /// Blog URL.
    let blog: URL?
    /// RSS URL.
    let rss: URL?

    /// Creates a new `ContactDetails`.
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
    init(
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
