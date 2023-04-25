import Foundation

extension JSONDecoder {

    public static var policeDataAPI: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .policeDataAPI
        return decoder
    }

}
