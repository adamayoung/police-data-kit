//
//  ContactDetails+Mocks.swift
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

extension ContactDetails {

    static var mock: Self {
        ContactDetails(
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

    static var mockNone: Self {
        ContactDetails()
    }

}
