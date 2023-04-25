import Foundation
@testable import PoliceAPIData

extension ContactDetailsDataModel {

    static var mock: ContactDetailsDataModel {
        ContactDetailsDataModel(
            email: "centralleicester.npa@leicestershire.pnn.police.uk",
            telephone: "101",
            mobile: "0123456789",
            fax: "0987654321",
            web: URL(string: "https://www.police.uk")!,
            address: "999 Letsbehavinyou, FakeTown",
            facebook: URL(string: "https://www.facebook.com/leicspolice")!,
            twitter: URL(string: "https://www.twitter.com/centralleicsNPA")!,
            youtube: URL(string: "https://www.youtube.com/watch?v=AM3Z7WiWksU")!,
            myspace: URL(string: "https://myspace.com/thepolice")!,
            bebo: URL(string: "https://bebo.com/thepolice")!,
            flickr: URL(string: "https://www.flickr.com/photos/tags/police")!,
            forum: URL(string: "https://www.forum.com/thepolice")!,
            blog: URL(string: "https://police.community/blogs/")!,
            rss: URL(string: "https://www.westyorkshire.police.uk/news/releases/feed")!
        )
    }

    static var mockNone: ContactDetailsDataModel {
        ContactDetailsDataModel()
    }

}
