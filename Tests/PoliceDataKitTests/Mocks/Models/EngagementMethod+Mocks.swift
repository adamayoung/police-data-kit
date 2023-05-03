import Foundation
@testable import PoliceDataKit

extension EngagementMethod {

    static var mock: Self {
        EngagementMethod(
            title: "Facebook",
            description: "Become friends with Leicestershire Constabulary",
            url: URL(string: "http://www.facebook.com/pages/Leicester/Leicestershire-Police/76807881169")
        )
    }

    static var mockNoURL: Self {
        EngagementMethod(
            title: "telephone",
            description: "101"
        )
    }

}
