import Foundation

struct MockError: LocalizedError {

    private let message: String

    init(message: String = "") {
        self.message = message
    }

    var errorDescription: String? {
        message
    }

}
