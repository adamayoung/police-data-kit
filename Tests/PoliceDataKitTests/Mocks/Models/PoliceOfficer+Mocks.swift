//
//  PoliceOfficer+Mocks.swift
//  PoliceDataKit
//
//  Copyright © 2024 Adam Young.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an AS IS BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
@testable import PoliceDataKit

extension PoliceOfficer {

    static var mock: Self {
        PoliceOfficer(
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
            contactDetails: ContactDetails(
                twitter: URL(string: "http://www.twitter.com/ACCCLeicsPolice")
            )
        )
    }

    static var mockNoBioOrContactDetails: Self {
        PoliceOfficer(
            name: "Dave Smith",
            rank: nil,
            bio: nil,
            contactDetails: ContactDetails()
        )
    }

    static var mocks: [Self] {
        [
            .mock,
            PoliceOfficer(
                name: "Dave Smith",
                rank: "Chief Constable",
                contactDetails: ContactDetails(
                    email: "dave.smith@police.uk"
                )
            )
        ]
    }

}
