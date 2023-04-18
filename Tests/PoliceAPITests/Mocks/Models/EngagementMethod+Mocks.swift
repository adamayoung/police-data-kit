import Foundation
import PoliceAPI

extension EngagementMethod {

    static var mock: EngagementMethod {
        EngagementMethod(
            title: "Facebook",
            description: "Become friends with Leicestershire Constabulary",
            url: URL(string: "http://www.facebook.com/pages/Leicester/Leicestershire-Police/76807881169")!
        )
    }

    static var mockNoURL: EngagementMethod {
        EngagementMethod(
            title: "telephone",
            description: "101"
        )
    }

}
