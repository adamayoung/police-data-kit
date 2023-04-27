import Foundation

struct ContactDetailsDataModel: Decodable, Equatable {

    let email: String?
    let telephone: String?
    let mobile: String?
    let fax: String?
    let web: URL?
    let address: String?
    let facebook: URL?
    let twitter: URL?
    let youtube: URL?
    let myspace: URL?
    let bebo: URL?
    let flickr: URL?
    let forum: URL?
    let blog: URL?
    let rss: URL?

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
