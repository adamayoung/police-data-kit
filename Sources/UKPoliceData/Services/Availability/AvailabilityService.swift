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
