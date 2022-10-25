import Foundation

extension Data {

    init(fromResource fileName: String, withExtension fileType: String) throws {
        guard let filepath = Bundle.module.url(forResource: fileName, withExtension: fileType) else {
            throw LoadDataError()
        }

        try self.init(contentsOf: filepath)
    }

}

struct LoadDataError: Error {

    init() { }

}
