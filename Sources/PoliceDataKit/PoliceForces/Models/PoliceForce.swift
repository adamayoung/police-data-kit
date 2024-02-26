//
//  PoliceForce.swift
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
/// A model representing a police force.
///
public struct PoliceForce: Identifiable, Equatable, Codable {

    /// Unique police force identifier.
    public let id: String

    /// Police force name.
    public let name: String

    /// Description.
    public let description: String?

    /// Telephone number.
    public let telephone: String

    /// Police force website URL.
    public let url: URL

    /// Engagement methods - Ways to keep informed.
    public let engagementMethods: [EngagementMethod]

    ///
    /// Creates a police force object.
    ///
    /// - Parameters:
    ///   - id: Unique force identifier.
    ///   - name: Force name.
    ///   - description: Description.
    ///   - telephone: Telephone number.
    ///   - url: Police Force website URL.
    ///   - engagementMethods: Engagement methods - Ways to keep informed.
    ///
    public init(
        id: String,
        name: String,
        description: String? = nil,
        telephone: String,
        url: URL,
        engagementMethods: [EngagementMethod] = []
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.telephone = telephone
        self.url = url
        self.engagementMethods = engagementMethods
    }

}
