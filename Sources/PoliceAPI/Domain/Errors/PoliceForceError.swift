import Foundation

public enum PoliceForceError: LocalizedError, Equatable {

    case notFound
    case network(Error)
    case unknown

}

extension PoliceForceError {

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
