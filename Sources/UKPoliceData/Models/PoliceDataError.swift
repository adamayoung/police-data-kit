import Foundation

/// Police Data Error.
public enum PoliceDataError: Error, Equatable {

    /// Network error.
    case network(Error)
    /// Not found.
    case notFound
    /// Unknown error.
    case unknown
    /// Data decoding error.
    case decode(Error)

    public static func == (lhs: PoliceDataError, rhs: PoliceDataError) -> Bool {
        switch (lhs, rhs) {
        case (.network(let lhsError), .network(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription

        case (.notFound, .notFound):
            return true

        case (.unknown, .unknown):
            return true

        case (.decode, .decode):
            return true

        default:
            return false
        }
    }

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
