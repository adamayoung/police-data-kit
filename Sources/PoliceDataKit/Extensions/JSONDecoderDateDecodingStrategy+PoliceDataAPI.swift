//
//  JSONDecoderDateDecodingStrategy+PoliceDataAPI.swift
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

extension JSONDecoder.DateDecodingStrategy {

    static var policeDataAPI: JSONDecoder.DateDecodingStrategy {
        .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)

            if let date = DateFormatter.dateTime.date(from: string) {
                return date
            }

            if let date = DateFormatter.dateTimeWithTimeZoneOffset.date(from: string) {
                return date
            }

            if let date = DateFormatter.yearMonth.date(from: string) {
                return date
            }

            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Date is in invalid format")
        }
    }

}
