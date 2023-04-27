import Foundation

///
/// An error PoliceDataKit returns.
///
public enum OutcomeError: LocalizedError, Equatable {

    /// An error indicating a crime could not be found.
    case notFound

    /// An error indicating the location that was specified is outside the region there is data for.
    case locationOutsideOfDataSetRegion

    /// An error indicating there was a network problem.
    case network(Error)

    /// An unknown error.
    case unknown

}

extension OutcomeError {

    /// A localized message describing what error occurred.
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

extension OutcomeError {

    /// Returns a Boolean value indicating whether two `OutcomeError`s are equal.
    public static func == (lhs: OutcomeError, rhs: OutcomeError) -> Bool {
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
