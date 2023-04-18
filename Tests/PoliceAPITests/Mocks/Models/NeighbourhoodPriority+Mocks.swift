import Foundation
@testable import PoliceAPI

extension NeighbourhoodPriority {

    static var mock: NeighbourhoodPriority {
        NeighbourhoodPriority(
            issue: "To reduce street drinking and drug use in and around Museum Square, Leicester.",
            issueDate: DateFormatter.dateTime.date(from: "2015-10-08T00:00:00")!,
            action: "Following the closure of a property on West Street, the number of incidents of Anti-Social "
                + "behaviour reported to the Leicestershire Police has dramatically reduced; we are therefore closing "
                + "this priority. Local residents and businesses have been informed of this decision. The local "
                + "Dedicated Neighbourhood team will remain vigilant and will re-evaluate the problem should it "
                + "return.",
            actionDate: DateFormatter.dateTime.date(from: "2015-12-22T00:00:00")
        )
    }

    static var mockNoAction: NeighbourhoodPriority {
        NeighbourhoodPriority(
            issue: "To reduce the amount of Anti-Social Behaviour Humberstone Gate, Leicester.",
            issueDate: DateFormatter.dateTime.date(from: "2016-04-14T00:00:00")!
        )
    }

    static var mockWithHTML: NeighbourhoodPriority {
        NeighbourhoodPriority(
            issue: "Beggars and homeless persons are using private premises, stairwells, side alleys and doorways to "
                + "beg and sleep. This can sometimes bring other issues such as drug or alcohol misuse, needles, "
                + "General ASB and even harassment or distress to some residents / passers by. There is also an "
                + "environmental issue with personal rubbish being left in the street.\nThere have also been concerns "
                + "raised regarding the on-going welfare of those persons consistently rough sleeping / begging in the "
                + "area.",
            issueDate: DateFormatter.dateTime.date(from: "2018-09-20T00:00:00")!,
            action: "Having reviewed the number of calls received from the community this year compared to last year "
                + "as well as on-going patrols there is a noticeable reduction in both persistent begging and homeless "
                + "persons in and around the Narborough Rd and surrounding areas. We have completed numerous referrals "
                + "to housing, shelter and Turning Point organisations to provide help and support those people in "
                + "need. We have given verbal and written warnings to those identified as causing public nuisance by "
                + "persistent or aggressive begging as well as liaising with both the local residential and business "
                + "communities around this issue. Thank you for your on-going support and please continue to report "
                + "any issues to your local Police Team. Sgt Dyer",
            actionDate: DateFormatter.dateTime.date(from: "2019-01-14T00:00:00")!
        )
    }

    static var mocks: [NeighbourhoodPriority] {
        [
            .mock,
            .mockNoAction,
            .mockWithHTML
        ]
    }

}
