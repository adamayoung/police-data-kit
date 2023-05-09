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
    public var url: URL?

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
        self.url = try {
            guard let urlString = try container.decodeIfPresent(String.self, forKey: .url) else {
                return nil
            }

            return URL(string: urlString)
        }()
    }

    public func encode(to encoder: Encoder) throws {
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
