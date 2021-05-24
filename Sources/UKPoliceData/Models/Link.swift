import Foundation

/// Associated link.
public struct Link: Decodable, Equatable {

    /// Title of the link.
    public let title: String
    /// Description of the link.
    public let description: String?
    /// URL.
    public var url: URL? {
        URL(string: urlString)
    }

    private let urlString: String

    /// Creates a a new `Link`.
    ///
    /// - Parameters:
    ///     - title: Title of the link.
    ///     - description: Description of the link.
    ///     - url: URL.
    public init(title: String, description: String? = nil, url: URL? = nil) {
        self.title = title
        self.description = description
        self.urlString = url?.absoluteString ?? ""
    }

}

extension Link {

    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlString = "url"
    }

}
