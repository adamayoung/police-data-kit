//
//  PoliceOfficer.swift
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

///
/// A model representing a police officer.
///
public struct PoliceOfficer: Equatable, Codable {

    /// Name of the person.
    public let name: String

    /// Police Force rank.
    public let rank: String?

    /// Officer biography.
    public let bio: String?

    /// Contact details for the Officer.
    public let contactDetails: ContactDetails

    ///
    /// Creates a police office object.
    ///
    /// - Parameters:
    ///   - name: Name of the person.
    ///   - rank: Police Force rank.
    ///   - bio: Officer biography.
    ///   - contactDetails: Contact details for the Officer.
    ///
    public init(
        name: String,
        rank: String? = nil,
        bio: String? = nil,
        contactDetails: ContactDetails
    ) {
        self.name = name
        self.rank = rank
        self.bio = bio
        self.contactDetails = contactDetails
    }

}
