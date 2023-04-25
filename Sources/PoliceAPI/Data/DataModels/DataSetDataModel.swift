import Foundation

struct DataSetDataModel: Decodable, Equatable, Comparable {

    /// Year and month of all available street level crime data.
    let date: Date
    /// A list of police force identifiers for police forces that have provided stop and search data for this month.
    let stopAndSearch: [String]

    /// Creates a new `DataSet`.
    ///
    /// - Parameters:
    ///   - date: Year and month of all available street level crime data.
    ///   - name: A list of police force identifiers for police forces that have provided stop and search data for this month.
    init(date: Date, stopAndSearch: [String]) {
        self.date = date
        self.stopAndSearch = stopAndSearch
    }

    static func < (lhs: DataSetDataModel, rhs: DataSetDataModel) -> Bool {
        lhs.date < rhs.date
    }

}

extension DataSetDataModel {

    private enum CodingKeys: String, CodingKey {
        case date
        case stopAndSearch = "stop-and-search"
    }

}
