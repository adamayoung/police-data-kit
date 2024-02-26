//
//  Neighbourhood+Mocks.swift
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

import CoreLocation
import Foundation
@testable import PoliceDataKit

extension Neighbourhood {

    static var mock: Self {
        Neighbourhood(
            id: "NC04",
            name: "City Centre",
            description: "<p>The Castle neighbourhood is a diverse covering all of the City Centre. In addition it "
                + "covers De Montfort University, the University of Leicester, Leicester Royal Infirmary, the "
                + "Leicester Tigers rugby ground and the Clarendon Park and Riverside communities.</p>\n<p>The "
                + "Highcross and Haymarket shopping centres and Leicester's famous Market are all covered by this "
                + "neighbourhood.</p>",
            policeForceWebsiteURL: URL(string: "http://www.leics.police.uk/local-policing/city-centre"),
            population: 1000,
            contactDetails: ContactDetails(
                email: "centralleicester.npa@leicestershire.pnn.police.uk",
                telephone: "101",
                facebook: URL(string: "http://www.facebook.com/leicspolice")!,
                twitter: URL(string: "http://www.twitter.com/centralleicsNPA")!
            ),
            center: CLLocationCoordinate2D(latitude: 52.6389, longitude: -1.13619),
            locations: [
                NeighbourhoodLocation(
                    name: "Mansfield House",
                    type: "station",
                    address: "74 Belgrave Gate\n, Leicester",
                    postcode: "LE1 3GG"
                )
            ],
            links: [
                Link(
                    title: "Leicester City Council",
                    url: URL(string: "http://www.leicester.gov.uk/")
                )
            ]
        )
    }

    static var mockWithAmpersandInName: Self {
        Neighbourhood(
            id: "AB12",
            name: "Banks & Hesketh",
            description: "Some & description",
            policeForceWebsiteURL: URL(string: "http://www.leics.police.uk/local-policing/city-centre"),
            population: 1000,
            center: CLLocationCoordinate2D(latitude: 52.6389, longitude: -1.13619)
        )
    }

}
