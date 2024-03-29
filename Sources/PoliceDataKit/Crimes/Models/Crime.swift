//
//  Crime.swift
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
/// A model representing a crime.
///
public struct Crime: Identifiable, Equatable, Codable {

    /// Identifier of the crime.
    ///
    /// This ID only relates to the API, it is NOT a police identifier.
    public let id: Int

    /// 64-character unique identifier for the crime.
    ///
    /// This is different to the existing 'id' attribute, which is not guaranteed to always stay the same for each crime.
    public let crimeID: String

    /// Extra information about the crime.
    public let context: String?

    /// Crime category identifier.
    public let categoryID: String

    /// Approximate location of the incident.
    ///
    /// The latitude and longitude locations of Crime and ASB incidents published always represent the approximate location
    /// of a crime — not the exact place that it happened.
    ///
    /// [https://data.police.uk/about/#location-anonymisation](https://data.police.uk/about/#location-anonymisation)
    public let location: Location?

    /// The type of the location.
    public let locationType: CrimeLocationType?

    /// For Bristish Transport Police locations, the type of location at which this crime was recorded.
    public let locationSubtype: String?

    /// Date (truncated to the year and month) of the crime.
    public let date: Date

    /// The category and date of the latest recorded outcome for the crime.
    public let outcomeStatus: OutcomeStatus?

    ///
    /// Creates a crime object.
    ///
    /// - Parameters:
    ///   - id: Identifier of the crime
    ///   - crimeID: 64-character unique identifier for the crime.
    ///   - context: Extra information about the crime.
    ///   - categoryID: Crime category identifier.
    ///   - location: Approximate location of the incident.
    ///   - locationType: The type of the location
    ///   - locationSubtype: For Bristish Transport Police locations, the type of location at which this crime was recorded.
    ///   - date: Date of the crime.
    ///   - outcomeStatus: The category and date of the latest recorded outcome for the crime.
    ///
    public init(
        id: Int,
        crimeID: String,
        context: String? = nil,
        categoryID: String,
        location: Location? = nil,
        locationType: CrimeLocationType? = nil,
        locationSubtype: String? = nil,
        date: Date,
        outcomeStatus: OutcomeStatus? = nil
    ) {
        self.id = id
        self.crimeID = crimeID
        self.context = context
        self.categoryID = categoryID
        self.location = location
        self.locationType = locationType
        self.locationSubtype = locationSubtype
        self.date = date
        self.outcomeStatus = outcomeStatus
    }

}

extension Crime {

    private enum CodingKeys: String, CodingKey {
        case id
        case crimeID = "persistentId"
        case context
        case categoryID = "category"
        case location
        case locationType
        case locationSubtype
        case date = "month"
        case outcomeStatus
    }

}
