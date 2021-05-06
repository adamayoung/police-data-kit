import Foundation

/// Police Data Error.
public enum PoliceDataError: Error {

    /// Network error.
    case network(Error)
    /// Not found.
    case notFound
    /// Unknown error.
    case unknown
    /// Data decoding error.
    case decode(Error)

}

extension PoliceDataError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .network(let error):
            return error.localizedDescription

        case .notFound:
            return "Not Found"

        case .unknown:
            return "Unknown Error"

        case .decode:
            return "Data Decode Error"
        }
    }

}
