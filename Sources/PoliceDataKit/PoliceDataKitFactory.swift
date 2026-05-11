//
//  PoliceDataKitFactory.swift
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

enum PoliceDataKitFactory {

    static let apiClient: any APIClient & Sendable = PoliceDataAPIClient(
        baseURL: policeDataBaseURL,
        urlSession: urlSession,
        serialiser: serialiser
    )

    static let availabilityCache: any AvailabilityCache & Sendable = AvailabilityDefaultCache(
        cacheStore: cacheStore
    )

    static let crimeCache: any CrimeCache & Sendable = CrimeDefaultCache(cacheStore: cacheStore)

    static let neighbourhoodCache: any NeighbourhoodCache & Sendable = NeighbourhoodDefaultCache(
        cacheStore: cacheStore
    )

    static let outcomeCache: any OutcomeCache & Sendable = OutcomeDefaultCache(cacheStore: cacheStore)

    static let policeForceCache: any PoliceForceCache & Sendable = PoliceForceDefaultCache(
        cacheStore: cacheStore
    )

    static let stopAndSearchCache: any StopAndSearchCache & Sendable = StopAndSearchDefaultCache(
        cacheStore: cacheStore
    )

}

extension PoliceDataKitFactory {

    private static let urlSession = URLSession(configuration: urlSessionConfiguration)

    private static var urlSessionConfiguration: URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        #if os(iOS)
            configuration.multipathServiceType = .handover
        #endif

        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 30

        return configuration
    }

    static let cacheStore: any Cache & Sendable = InMemoryCache(name: "PoliceDataKitCache")

    private static let serialiser: any Serialiser & Sendable = JSONSerialiser(decoder: .policeDataAPI)

}

extension PoliceDataKitFactory {

    private static let policeDataBaseURL = URL(string: "https://data.police.uk/api")!

}
