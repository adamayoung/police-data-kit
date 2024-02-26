//
//  AvailabilityService.swift
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
import os

///
/// Provides an interface for obtaining availability data sets from the UK Police API.
///
@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12, *)
public final class AvailabilityService {

    ///
    /// A single, shared availability service object.
    ///
    /// Use this object to interface to availability services in your application.
    ///
    public static let shared = AvailabilityService()

    private static let logger = Logger(subsystem: Logger.policeDataKit, category: "AvailabilityService")

    private let apiClient: any APIClient
    private let cache: any AvailabilityCache

    ///
    /// Creates an availability service object.
    ///
    /// Use this method to create different `AvailabilityService` instances. If you only need one instance of
    /// `AvailabilityService`, use `shared`.
    ///
    public convenience init() {
        self.init(
            apiClient: PoliceDataKitFactory.apiClient,
            cache: PoliceDataKitFactory.availabilityCache
        )
    }

    init(apiClient: some APIClient, cache: some AvailabilityCache) {
        self.apiClient = apiClient
        self.cache = cache
    }

    ///
    /// Returns the available data sets.
    ///
    /// [https://data.police.uk/docs/method/crimes-street-dates/](https://data.police.uk/docs/method/crimes-street-dates/)
    ///
    /// - Throws: Availability data error ``AvailabilityError``.
    ///
    /// - Returns: The available data sets.
    ///
    public func availableDataSets() async throws -> [DataSet] {
        Self.logger.trace("fetching available data sets")

        if let cachedDataSets = await cache.availableDataSets() {
            return cachedDataSets
        }

        let dataSets: [DataSet]
        do {
            dataSets = try await apiClient.get(endpoint: AvailabilityEndpoint.dataSets)
        } catch let error {
            Self.logger.error("failed fetching available data sets: \(error.localizedDescription)")
            throw Self.mapToAvailabilityError(error)
        }

        await cache.setAvailableDataSets(dataSets)

        return dataSets
    }

}

extension AvailabilityService {

    private static func mapToAvailabilityError(_ error: Error) -> AvailabilityError {
        guard let error = error as? APIClientError else {
            return .unknown
        }

        switch error {
        case .network:
            return .network(error)

        case .notFound, .decode, .unknown:
            return .unknown
        }
    }

}
