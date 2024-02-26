//
//  EngagementMethod.swift
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
/// A model representing an engagement method - ways to keep informed.
///
public struct EngagementMethod: Equatable, Codable {

    /// Engagement method title.
    public let title: String

    /// Engagement method description.
    public let description: String?

    /// Engagement method website URL.
    public let url: URL?

    /// Creates a engagement method object.
    ///
    /// - Parameters:
    ///   - title: Engagement method type.
    ///   - description: Engagement method description.
    ///   - url: Engagement method website URL.
    ///
    public init(title: String, description: String? = nil, url: URL? = nil) {
        self.title = title
        self.description = description
        self.url = url
    }

}

public extension EngagementMethod {

    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.url = try {
            guard let urlString = try container.decodeIfPresent(String.self, forKey: .url) else {
                return nil
            }

            return URL(string: urlString)
        }()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(description, forKey: .description)
        let urlString: String = {
            guard let url else {
                return ""
            }

            return url.absoluteString
        }()
        try container.encode(urlString, forKey: .url)
    }

}
