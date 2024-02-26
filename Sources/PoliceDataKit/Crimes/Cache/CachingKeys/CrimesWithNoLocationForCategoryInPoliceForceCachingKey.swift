//
//  CrimesWithNoLocationForCategoryInPoliceForceCachingKey.swift
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

struct CrimesWithNoLocationForCategoryInPoliceForceCachingKey: CachingKey {

    let categoryID: CrimeCategory.ID
    let policeForceID: PoliceForce.ID
    let date: Date

    var keyValue: String {
        "crimes-with-no-location-in-category-\(categoryID)-police-force-\(policeForceID)-date-\(dateKey)"
    }

    private var dateKey: String {
        DateFormatter.yearMonth.string(from: date)
    }

    init(categoryID: CrimeCategory.ID, policeForceID: PoliceForce.ID, date: Date) {
        self.categoryID = categoryID
        self.policeForceID = policeForceID
        self.date = date
    }

}
