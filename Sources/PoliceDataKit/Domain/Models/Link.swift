import Foundation

///
/// A model representing an associated link.
///
public struct Link: Equatable {

    /// Title of the link.
    public let title: String

    /// Description of the link.
    public let description: String?

    /// Link URL.
    public var url: URL?

    ///
    /// Creates a link object.
    ///
    /// - Parameters:
    ///   - title: Title of the link.
    ///   - description: Description of the link.
    ///   - url: URL.
    ///
    public init(title: String, description: String? = nil, url: URL? = nil) {
        self.title = title
        self.description = description
        self.url = url
    }

}
