import Foundation

extension JSONDecoder {

    static var policeDataAPI: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(.policeDataAPI)
        return decoder
    }

}
