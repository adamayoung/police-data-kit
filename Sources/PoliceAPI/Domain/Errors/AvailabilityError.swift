import Foundation

public enum AvailabilityError: LocalizedError, Equatable {

    case network(Error)
    case unknown

}

extension AvailabilityError {

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
