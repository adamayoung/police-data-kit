import Foundation
@testable import PoliceAPI

extension PoliceOfficerDataModel {

    static var mock: PoliceOfficerDataModel {
        PoliceOfficerDataModel(
            name: "Roger Bannister",
            rank: "Assistant Chief Officer (Crime)",
            bio: "Roger joined Lincolnshire Police in 1988 having attended Queen Elizabeth Grammar School in "
                + "Gainsborough and then working in retail management in London. He progressed through the ranks both "
                + "in uniformed operations and criminal investigation roles, particularly enjoying his experience as a "
                + "detective. He has a degree in Policing Studies.\nRoger describes his two proudest career moments as "
                + "being commended as a Detective Sergeant for detecting a knife-point stranger kidnap and sex attack "
                + "on a young schoolgirl and then ten years later, as the Head of CID, being commended over a "
                + "four-year long global child protection investigation.\nIn October 2010 Roger took up the role as "
                + "temporary Assistant Chief Constable (Protective Services) in Lincolnshire Police and in March 2012 "
                + "graduated from the Strategic Command Course.\nHe was appointed as Leicestershire Police’s Assistant "
                + "Chief Constable (Crime) in June 2013.\nRoger is married and has six year old twin boys. His many "
                + "hobbies include mountaineering (which has included trips to Scotland, the Alps and the Himalayas) "
                + "skiing, running and open water swimming.",
            contactDetails: ContactDetailsDataModel(
                twitter: URL(string: "http://www.twitter.com/ACCCLeicsPolice")
            )
        )
    }

    static var mocks: [PoliceOfficerDataModel] {
        [
            .mock,
            PoliceOfficerDataModel(
                name: "Dave Smith",
                rank: "Chief Constable",
                contactDetails: ContactDetailsDataModel(
                    email: "dave.smith@police.uk"
                )
            )
        ]
    }

}
