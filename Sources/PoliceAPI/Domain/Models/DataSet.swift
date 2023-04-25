import Foundation

public struct DataSet: Equatable, Comparable {

    /// Year and month of all available street level crime data.
    public let date: Date
    /// A list of police force identifiers for police forces that have provided stop and search data for this month.
    public let stopAndSearch: [String]

    /// Creates a new `DataSet`.
    ///
    /// - Parameters:
    ///   - date: Year and month of all available street level crime data.
    ///   - name: A list of police force identifiers for police forces that have provided stop and search data for this month.
    public init(date: Date, stopAndSearch: [String]) {
        self.date = date
        self.stopAndSearch = stopAndSearch
    }

    public static func < (lhs: DataSet, rhs: DataSet) -> Bool {
        lhs.date < rhs.date
    }

}
