import Foundation

/// Associated link.
struct LinkDataModel: Decodable, Equatable {

    /// Title of the link.
    let title: String
    /// Description of the link.
    let description: String?
    /// URL.
    var url: URL?

    /// Creates a new `Link`.
    ///
    /// - Parameters:
    ///   - title: Title of the link.
    ///   - description: Description of the link.
    ///   - url: URL.
    init(title: String, description: String? = nil, url: URL? = nil) {
        self.title = title
        self.description = description
        self.url = url
    }

}

extension LinkDataModel {

    private enum CodingKeys: String, CodingKey {
        case title
        case description
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        let urlString = try container.decodeIfPresent(String.self, forKey: .url)
        self.url = URL(string: urlString ?? "")
    }

}
