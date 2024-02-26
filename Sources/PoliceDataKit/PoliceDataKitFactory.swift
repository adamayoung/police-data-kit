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

final class PoliceDataKitFactory {

    private init() {}

}

extension PoliceDataKitFactory {

    static let apiClient: some APIClient = PoliceDataAPIClient(
        baseURL: policeDataBaseURL,
        urlSession: urlSession,
        serialiser: serialiser
    )

    static var availabilityCache: some AvailabilityCache {
        AvailabilityDefaultCache(cacheStore: cacheStore)
    }

    static var crimeCache: some CrimeCache {
        CrimeDefaultCache(cacheStore: cacheStore)
    }

    static var neighbourhoodCache: some NeighbourhoodCache {
        NeighbourhoodDefaultCache(cacheStore: cacheStore)
    }

    static var outcomeCache: some OutcomeCache {
        OutcomeDefaultCache(cacheStore: cacheStore)
    }

    static var policeForceCache: some PoliceForceCache {
        PoliceForceDefaultCache(cacheStore: cacheStore)
    }

    static var stopAndSearchCache: some StopAndSearchCache {
        StopAndSearchDefaultCache(cacheStore: cacheStore)
    }

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

    static let cacheStore: some Cache = InMemoryCache(name: "PoliceDataKitCache")

    private static var serialiser: some Serialiser {
        JSONSerialiser(decoder: .policeDataAPI)
    }

}

extension PoliceDataKitFactory {

    private static var policeDataBaseURL: URL {
        URL(string: "https://data.police.uk/api")!
    }

}
