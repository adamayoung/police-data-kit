import Foundation

/// Engagement method - ways to keep informed.
public struct EngagementMethod: Decodable, Equatable {

    /// Engagement method type.
    public let title: EngagementMethodType
    /// Engagement method description.
    public let description: String
    /// Engagement method website URL.
    public let url: URL

    /// Creates a a new `EngagementMethod`.
    ///
    /// - Parameters:
    ///     - title: Engagement method type.
    ///     - description: Engagement method description.
    ///     - url: Engagement method website URL.
    public init(title: EngagementMethod.EngagementMethodType, description: String, url: URL) {
        self.title = title
        self.description = description
        self.url = url
    }

}

extension EngagementMethod {

    /// Engagement method type.
    public enum EngagementMethodType: String, Decodable, Equatable {

        /// Facebook.
        case facebook = "Facebook"
        /// Twitter.
        case twitter = "Twitter"
        /// YouTube.
        case youTube = "YouTube"
        /// RSS Feed.
        case rss = "RSS"
    }

}
