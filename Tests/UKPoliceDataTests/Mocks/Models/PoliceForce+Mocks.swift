import Foundation
import UKPoliceData

extension PoliceForce {

    static var mock: PoliceForce {
        PoliceForce(
            id: "leicestershire",
            name: "Leicestershire Constabulary",
            description: "h2.A police service for everyone\n\t\n\tLeicestershire Constabulary provides a policing "
                + "service to the people of Leicester, Leicestershire and Rutland 24-hours a day, 365-days of the "
                + "year.\n\nThe area we are responsible for covers over 2,500 square kilometres (over 965 square "
                + "miles) and has a population of nearly one million. There is a rich diversity of communities all "
                + "with their own policing needs.\n\nMany steps have been taken to bring policing back into the very "
                + "heart of local communities. This has included the replacement of older, larger or out-of-town "
                + "police buildings with modern, self-contained local policing units in the very centre of local "
                + "communities.\n\nEach of the 15 local policing units is headed by an inspector whose responsibility "
                + "is to ensure that their area receives a 24-hour policing service.\n\nTo help them provide this "
                + "service they are supported by specialist departments such as the dog section, the scientific "
                + "support department and the East Midlands air support unit.\n\nRather than waiting for crimes to be "
                + "committed, we are working more and more to plan operations and target criminals. Many of these "
                + "operations, which are aimed at tackling specific problems, involve working in partnership with "
                + "local residents and other agencies and have proved to be very successful.\n\nOver the years we have "
                + "forged close working relationships with local communities, other organisations and agencies and we "
                + "continue to develop and strengthen these partnerships, working together to fight crime and improve "
                + "the quality of life for everyone.",
            telephone: "0116 222 2222",
            url: URL(string: "http://www.leics.police.uk/")!,
            engagementMethods: [
                EngagementMethod(
                    title: "Facebook",
                    description: "Become friends with Leicestershire Constabulary",
                    url: URL(string: "http://www.facebook.com/pages/Leicester/Leicestershire-Police/76807881169")!
                ),
                EngagementMethod(
                    title: "Twitter",
                    description: "Keep up to date with Leicestershire Constabulary on Twitter",
                    url: URL(string: "http://www.twitter.com/leicspolice")!
                ),
                EngagementMethod(
                    title: "YouTube",
                    description: "See Leicestershire Constabulary's latest videos on YouTube",
                    url: URL(string: "http://www.youtube.com/leicspolice")!
                ),
                EngagementMethod(
                    title: "RSS",
                    description: "Keep informed with Leicestershire Constabulary's RSS feed",
                    url: URL(string: "http://www.leics.police.uk/rss/")!
                ),
                EngagementMethod(
                    title: "telephone",
                    description: "0116 222 2222"
                )
            ]
        )
    }

}
