//
//  URL+QueryItem.swift
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

extension URL {

    func appendingQueryItem(name: String, value: CustomStringConvertible) -> Self {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        var queryItems = urlComponents.queryItems ?? []
        queryItems.append(URLQueryItem(name: name, value: value.description))
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }

    func appendingQueryItem(name: String, date: Date?, formatter: DateFormatter = .yearMonth) -> Self {
        guard let date else {
            return self
        }

        let dateString = formatter.string(from: date)
        return appendingQueryItem(name: name, value: dateString)
    }

    func appendingQueryItem(name: String, coordinate: CLLocationCoordinate2D) -> Self {
        appendingQueryItem(name: name, value: "\(coordinate.latitude),\(coordinate.longitude)")
    }

    func appendingQueryItem(name: String, coordinates: [CLLocationCoordinate2D]) -> Self {
        let pairs = coordinates
            .map { "\($0.latitude),\($0.longitude)" }
            .joined(separator: ":")
        return appendingQueryItem(name: name, value: pairs)
    }

}
