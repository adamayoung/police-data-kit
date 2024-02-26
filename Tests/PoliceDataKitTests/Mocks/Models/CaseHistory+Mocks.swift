//
//  CaseHistory+Mocks.swift
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

extension CaseHistory {

    static var mock: Self {
        CaseHistory(
            crime: CaseHistoryCrime(
                id: 82_067_369,
                crimeID: "46688f40815e3a4cb7fcf69550492d8bffa4ed267652e676e49e23d00955c486",
                context: "",
                categoryID: "bicycle-theft",
                location: nil,
                locationType: nil,
                locationSubtype: "",
                date: DateFormatter.yearMonth.date(from: "2020-03")!
            ),
            outcomes: [
                CaseHistoryOutcome(
                    personID: nil,
                    date: DateFormatter.yearMonth.date(from: "2020-03")!,
                    category: OutcomeCategory(
                        id: "under-investigation",
                        name: "Under investigation"
                    )
                ),
                CaseHistoryOutcome(
                    personID: nil,
                    date: DateFormatter.yearMonth.date(from: "2020-03")!,
                    category: OutcomeCategory(
                        id: "no-further-action",
                        name: "Investigation complete; no suspect identified"
                    )
                )
            ]
        )
    }

}
