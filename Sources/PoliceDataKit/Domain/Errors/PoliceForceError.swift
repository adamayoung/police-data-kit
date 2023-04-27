import Foundation

///
/// An error PoliceDataKit returns.
///
public enum PoliceForceError: LocalizedError, Equatable {

    /// An error indicating a crime could not be found.
    case notFound

    /// An error indicating there was a network problem.
    case network(Error)

    /// An unknown error.
    case unknown

}

extension PoliceForceError {

    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
        case .notFound:
            return NSLocalizedString("NOT_FOUND", bundle: .module, comment: "Not found error")

        case .network:
            return NSLocalizedString("NETWORK_ERROR", bundle: .module, comment: "Network error")

        case .unknown:
            return NSLocalizedString("UNKNOWN_ERROR", bundle: .module, comment: "Unknown error")
        }
    }

}

extension PoliceForceError {

    /// Returns a Boolean value indicating whether two `PoliceForceError`s are equal.
    public static func == (lhs: PoliceForceError, rhs: PoliceForceError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound, .notFound):
            return true

        case (.network, .network):
            return true

        case (.unknown, .unknown):
            return true

        default:
            return false
        }
    }

}
