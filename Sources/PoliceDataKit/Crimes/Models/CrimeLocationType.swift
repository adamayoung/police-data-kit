//
//  CrimeLocationType.swift
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
/// The location type of a crime.
///
public enum CrimeLocationType: String, Equatable, CaseIterable, CustomStringConvertible, Codable {

    /// A normal police force location.
    case force = "Force"

    /// British Transport Police location.
    ///
    /// British Transport Police locations fall within normal police force boundaries.
    case britishTransportPolice = "BTP"

    /// The localized string describing the crime location type.
    public var description: String {
        switch self {
        case .force:
            NSLocalizedString("POLICE_FORCE", bundle: .module, comment: "Police Force")

        case .britishTransportPolice:
            NSLocalizedString("BRITISH_TRANSPORT_POLICE", bundle: .module, comment: "British Transport Police")
        }
    }

}
