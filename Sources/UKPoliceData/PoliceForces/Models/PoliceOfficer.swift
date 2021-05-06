import Foundation

/// A Police Officer.
public struct PoliceOfficer: Decodable, Equatable {

    /// Name of the person.
    public let name: String
    /// Police Force rank.
    public let rank: String
    /// Officer biography.
    public let bio: String?
    /// Contact details for the Officer.
    public let contactDetails: ContactDetails

    /// Creates a a new `ContactDetails`.
    ///
    /// - Parameters:
    ///     - name: Name of the person.
    ///     - rank: Police Force rank.
    ///     - bio: Officer biography.
    ///     - contactDetails: Contact details for the Officer.
    public init(name: String, rank: String, bio: String? = nil, contactDetails: ContactDetails) {
        self.name = name
        self.rank = rank
        self.bio = bio
        self.contactDetails = contactDetails
    }

}

extension PoliceOfficer {

    /// Contact details for the Officer.
    public struct ContactDetails: Decodable, Equatable {

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
        /// Google+ profile URL.
        let googlePlus: URL?
        /// Forum URL.
        let forum: URL?
        /// E-messaging URL.
        let eMessaging: URL?
        /// Blog URL.
        let blog: URL?
        /// RSS URL.
        let rss: URL?

        /// Creates a a new `ContactDetails`.
        ///
        /// - Parameters:
        ///     - email: Email address.
        ///     - telephone: Telephone number.
        ///     - mobile: Mobile number.
        ///     - fax: Fax number.
        ///     - web: Website address.
        ///     - address: Facebook profile URL.
        ///     - facebook: Facebook profile URL.
        ///     - twitter: Twitter profile URL.
        ///     - youtube: YouTube profile URL.
        ///     - myspace: Myspace profile URL.
        ///     - bebo: Bebo profile URL.
        ///     - flickr: Flickr profile URL.
        ///     - googlePlus: Google+ profile URL.
        ///     - forum: Forum URL.
        ///     - eMessaging: E-messaging URL.
        ///     - blog: Blog URL.
        ///     - rss: RSS URL.
        public init(email: String? = nil, telephone: String? = nil, mobile: String? = nil, fax: String? = nil,
                    web: URL? = nil, address: String? = nil, facebook: URL? = nil, twitter: URL? = nil,
                    youtube: URL? = nil, myspace: URL? = nil, bebo: URL? = nil, flickr: URL? = nil,
                    googlePlus: URL? = nil, forum: URL? = nil, eMessaging: URL? = nil, blog: URL? = nil,
                    rss: URL? = nil) {
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
            self.googlePlus = googlePlus
            self.forum = forum
            self.eMessaging = eMessaging
            self.blog = blog
            self.rss = rss
        }

    }

}
