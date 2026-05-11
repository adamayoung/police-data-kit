//
//  NeighbourhoodEvent.swift
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
/// A model representing a neighbourhood event.
///
public struct NeighbourhoodEvent: Equatable, Codable, Sendable {

    /// Event title.
    public let title: String

    /// Event type.
    public let type: String

    /// Event description.
    public let description: String

    /// Event address.
    public let address: String?

    /// Event start date.
    public let startDate: Date

    /// Event end date.
    public let endDate: Date?

    ///
    /// Creates a neighbourhood event object.
    ///
    /// - Parameters:
    ///   - title: Event title.
    ///   - type: Event type.
    ///   - description: Event description.
    ///   - address: Event address.
    ///   - startDate: Event start date.
    ///   - endDate: Event end date.
    ///
    public init(
        title: String,
        type: String,
        description: String,
        address: String? = nil,
        startDate: Date,
        endDate: Date? = nil
    ) {
        self.title = title
        self.type = type
        self.description = description
        self.address = address
        self.startDate = startDate
        self.endDate = endDate
    }

}
