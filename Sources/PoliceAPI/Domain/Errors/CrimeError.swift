import Foundation

public enum CrimeError: LocalizedError, Equatable {

    case notFound
    case locationOutsideOfDataSetRegion
    case network(Error)
    case unknown

}

extension CrimeError {

    public var errorDescription: String? {
        switch self {
        case .notFound:
            return NSLocalizedString("NOT_FOUND", bundle: .module, comment: "Not found error")

        case .locationOutsideOfDataSetRegion:
            return NSLocalizedString("LOCATION_OUTSIDE_OF_DATA_SET_REGION", bundle: .module,
                                     comment: "Location outside of data set region")

        case .network:
            return NSLocalizedString("NETWORK_ERROR", bundle: .module, comment: "Network error")

        case .unknown:
            return NSLocalizedString("UNKNOWN_ERROR", bundle: .module, comment: "Unknown error")
        }
    }

}

extension CrimeError {

    public static func == (lhs: CrimeError, rhs: CrimeError) -> Bool {
        switch (lhs, rhs) {
        case (.notFound, .notFound):
            return true

        case (.locationOutsideOfDataSetRegion, .locationOutsideOfDataSetRegion):
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
