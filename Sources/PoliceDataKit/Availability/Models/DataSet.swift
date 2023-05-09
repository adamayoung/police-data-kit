import Foundation

///
/// A model representing a data set.
///
public struct DataSet: Equatable, Codable {

    /// Year and month of all available street level crime data.
    public let date: Date

    /// A list of police force identifiers for police forces that have provided stop and search data for this month.
    public let stopAndSearch: [String]

    ///
    /// Creates a data set object.
    ///
    /// - Parameters:
    ///   - date: Year and month of all available street level crime data.
    ///   - stopAndSearch: A list of police force identifiers for police forces that have provided stop and search data for this month.
    ///
    public init(date: Date, stopAndSearch: [String]) {
        self.date = date
        self.stopAndSearch = stopAndSearch
    }

}

extension DataSet {

    private enum CodingKeys: String, CodingKey {
        case date
        case stopAndSearch = "stop-and-search"
    }

}
