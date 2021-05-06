import Foundation

/// Police Data API.
///
/// The API provides a rich data source for information, including: Neighbourhood team members. Upcoming events.
/// Street-level crime and outcome data. Nearest police stations.
///
/// - Note: [Police API Documentation](https://data.police.uk/docs/)
public protocol PoliceDataAPI {

    /// Police Forces.
    var policeForces: PoliceForceService { get }

}
