import Foundation

///
/// A model representing an engagement method - ways to keep informed.
///
public struct EngagementMethod: Equatable {

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
