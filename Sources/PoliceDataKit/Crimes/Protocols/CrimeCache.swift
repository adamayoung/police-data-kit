//
//  CrimeCache.swift
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

protocol CrimeCache {

    func crimes(forStreet streetID: Int, date: Date) async -> [Crime]?

    func setCrimes(_ crimes: [Crime], forStreet streetID: Int, date: Date) async

    func crimesWithNoLocation(
        forCategory categoryID: CrimeCategory.ID,
        inPoliceForce policeForceID: PoliceForce.ID,
        date: Date
    ) async -> [Crime]?

    func setCrimesWithNoLocation(
        _ crimes: [Crime],
        forCategory categoryID: CrimeCategory.ID,
        inPoliceForce policeForceID: PoliceForce.ID,
        date: Date
    ) async

    func crimeCategories(forDate date: Date) async -> [CrimeCategory]?

    func setCrimeCategories(_ crimeCategories: [CrimeCategory], forDate date: Date) async

}
