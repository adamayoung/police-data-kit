import Foundation

#if canImport(Combine)
import Combine
#endif

/// Get information about available of data.
public protocol AvailabilityService {

    /// Fetches a list of available data sets.
    ///
    /// - Note: [Police API | Availability](https://data.police.uk/docs/method/crimes-street-dates/)
    ///
    /// - Parameters:
    ///     - completion: Completion handler.
    ///     - result: A list of available data sets.
    func fetchAvailableDataSets(completion: @escaping (_ result: Result<[DataSet], PoliceDataError>) -> Void)

    #if canImport(Combine)
    /// Publishes a list of available data sets.
    ///
    /// - Note: [Police API | Availability](https://data.police.uk/docs/method/crimes-street-dates/)
    ///
    /// - Returns: A publisher with a list of available data sets.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func availableDataSetsPublisher() -> AnyPublisher<[DataSet], PoliceDataError>
    #endif

}

#if swift(>=5.5)
@available(macOS 12, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension AvailabilityService {

    /// Returns a list of available data sets.
    ///
    /// - Note: [Police API | Availability](https://data.police.uk/docs/method/crimes-street-dates/)
    ///
    /// - Returns: A list of available data sets.
    func availableDataSets() async throws -> [DataSet] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchAvailableDataSets(completion: continuation.resume(with:))
        }
    }

}
#endif
