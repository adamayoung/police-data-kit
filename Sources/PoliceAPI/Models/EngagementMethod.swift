import Foundation

/// Engagement method - ways to keep informed.
public struct EngagementMethod: Decodable, Equatable {

    /// Engagement method title.
    public let title: String
    /// Engagement method description.
    public let description: String?
    /// Engagement method website URL.
    public var url: URL?

    /// Creates a new `EngagementMethod`.
    ///
    /// - Parameters:
    ///   - title: Engagement method type.
    ///   - description: Engagement method description.
    ///   - url: Engagement method website URL.
    public init(title: String, description: String? = nil, url: URL? = nil) {
        self.title = title
        self.description = description
        self.url = url
    }

}

extension EngagementMethod {

    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case url
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        let urlString = try container.decodeIfPresent(String.self, forKey: .url)
        self.url = URL(string: urlString ?? "")
    }

}
