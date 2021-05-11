import Foundation

/// Engagement method - ways to keep informed.
public struct EngagementMethod: Decodable, Equatable {

    /// Engagement method title.
    public let title: String
    /// Engagement method description.
    public let description: String?
    /// Engagement method website URL.
    public var url: URL? {
        URL(string: urlString)
    }

    private let urlString: String

    /// Creates a a new `EngagementMethod`.
    ///
    /// - Parameters:
    ///     - title: Engagement method type.
    ///     - description: Engagement method description.
    ///     - url: Engagement method website URL.
    public init(title: String, description: String? = nil, url: URL? = nil) {
        self.title = title
        self.description = description
        self.urlString = url?.absoluteString ?? ""
    }

}

extension EngagementMethod {

    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlString = "url"
    }

}
