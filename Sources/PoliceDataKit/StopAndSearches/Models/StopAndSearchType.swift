//
//  StopAndSearchType.swift
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
/// The type of a stop and search.
///
public enum StopAndSearchType: String, Equatable, CaseIterable, Codable {

    /// Person search.
    case personSearch = "Person search"

    /// Vehicle search.
    case vehicleSearch = "Vehicle search"

    /// Person and vehicle search.
    case personAndVehicleSearch = "Person and Vehicle search"

    /// A localized name describing the stop and search.
    public var localizedName: String {
        switch self {
        case .personSearch:
            NSLocalizedString("PERSON_SEARCH", bundle: .module, comment: "Person search")

        case .vehicleSearch:
            NSLocalizedString("VEHICLE_SEARCH", bundle: .module, comment: "Vehicle search")

        case .personAndVehicleSearch:
            NSLocalizedString("PERSON_AND_VEHICLE_SEARCH", bundle: .module, comment: "Person and Vehicle search")
        }
    }

}
