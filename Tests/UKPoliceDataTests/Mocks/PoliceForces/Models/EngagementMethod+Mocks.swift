import Foundation
import UKPoliceData

extension EngagementMethod {

    static var mockFacebook: EngagementMethod {
        EngagementMethod(
            title: .facebook,
            description: "Become friends with Leicestershire Constabulary",
            url: URL(string: "http://www.facebook.com/pages/Leicester/Leicestershire-Police/76807881169")!
        )
    }

    static var mockTwitter: EngagementMethod {
        EngagementMethod(
            title: .twitter,
            description: "Keep up to date with Leicestershire Constabulary on Twitter",
            url: URL(string: "http://www.twitter.com/leicspolice")!
        )
    }

    static var mockYouTube: EngagementMethod {
        EngagementMethod(
            title: .youTube,
            description: "See Leicestershire Constabulary's latest videos on YouTube",
            url: URL(string: "http://www.youtube.com/leicspolice")!
        )
    }

    static var mockRSS: EngagementMethod {
        EngagementMethod(
            title: .rss,
            description: "Keep informed with Leicestershire Constabulary's RSS feed",
            url: URL(string: "http://www.leics.police.uk/rss/")!
        )
    }

}
