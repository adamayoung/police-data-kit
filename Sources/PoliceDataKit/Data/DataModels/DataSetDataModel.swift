import Foundation

struct DataSetDataModel: Decodable, Equatable {

    let date: Date
    let stopAndSearch: [String]

    init(date: Date, stopAndSearch: [String]) {
        self.date = date
        self.stopAndSearch = stopAndSearch
    }

}

extension DataSetDataModel {

    private enum CodingKeys: String, CodingKey {
        case date
        case stopAndSearch = "stop-and-search"
    }

}
