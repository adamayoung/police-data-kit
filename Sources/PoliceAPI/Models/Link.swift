import Foundation

/// Associated link.
public struct Link: Decodable, Equatable {

    /// Title of the link.
    public let title: String
    /// Description of the link.
    public let description: String?
    /// URL.
    public var url: URL?

    /// Creates a new `Link`.
    ///
    /// - Parameters:
    ///   - title: Title of the link.
    ///   - description: Description of the link.
    ///   - url: URL.
    public init(title: String, description: String? = nil, url: URL? = nil) {
        self.title = title
        self.description = description
        self.url = url
    }

}

extension Link {

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
