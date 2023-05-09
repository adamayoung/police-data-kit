import Foundation

///
/// An error PoliceDataKit returns.
///
public enum AvailabilityError: LocalizedError, Equatable {

    /// An error indicating there was a network problem.
    case network(Error)

    /// An unknown error.
    case unknown

}

extension AvailabilityError {

    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
        case .network:
            return NSLocalizedString("NETWORK_ERROR", bundle: .module, comment: "Network error")

        case .unknown:
            return NSLocalizedString("UNKNOWN_ERROR", bundle: .module, comment: "Unknown error")
        }
    }

}

extension AvailabilityError {

    /// Returns a Boolean value indicating whether two `AvailabilityError`s are equal.
    public static func == (lhs: AvailabilityError, rhs: AvailabilityError) -> Bool {
        switch (lhs, rhs) {
        case (.network, .network):
            return true

        case (.unknown, .unknown):
            return true

        default:
            return false
        }
    }

}
