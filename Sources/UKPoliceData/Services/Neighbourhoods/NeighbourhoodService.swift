import Foundation

#if canImport(Combine)
import Combine
#endif

/// Get information about a Police Force Neighbourhoods.
public protocol NeighbourhoodService {

    /// Fetches a list of all the neighbourhoods in a police force.
    ///
    /// - Note: [Police API | List of neighbourhoods for a force](https://data.police.uk/docs/method/neighbourhoods/)
    ///
    /// - Parameters:
    ///     - policeForceID: Police Force identifier.
    ///     - completion: Completion handler.
    ///     - result: A list of Neighbourhoods.
    func fetchAll(inPoliceForce policeForceID: String,
                  completion: @escaping (_ result: Result<[NeighbourhoodReference], PoliceDataError>) -> Void)

    /// Fetches details of a neighbourhood in a police force.
    ///
    /// - Note: [Police API | Specific neighbourhood](https://data.police.uk/docs/method/neighbourhood/)
    ///
    /// - Parameters:
    ///     - id: Neighbourhood identifier.
    ///     - policeForceID: Police Force identifier.
    ///     - completion: Completion handler.
    ///     - result: The matching Neighbourhood.
    func fetchDetails(forNeighbourhood id: String, inPoliceForce policeForceID: String,
                      completion: @escaping (_ result: Result<Neighbourhood, PoliceDataError>) -> Void)

    /// Fetches a list of coordinates that make up the boundary of a neighbourhood.
    ///
    /// - Note: [Police API | Neighbourhood boundary](https://data.police.uk/docs/method/neighbourhood-boundary/)
    ///
    /// - Parameters:
    ///     - neighbourhoodID: Neighbourhood identifier.
    ///     - policeForceID: Police Force identifier.
    ///     - completion: Completion handler.
    ///     - result: A list of coordinates that make up the boundary of the matching neighbourhood.
    func fetchBoundary(forNeighbourhood neighbourhoodID: String, inPoliceForce policeForceID: String,
                       completion: @escaping (_ result: Result<[Coordinate], PoliceDataError>) -> Void)

    /// Fetches a list of Police Officers who are members of the neighbourhood team for a neighbourhood.
    ///
    /// - Note: [Police API | Neighbourhood team](https://data.police.uk/docs/method/neighbourhood-team/)
    ///
    /// - Parameters:
    ///     - neighbourhoodID: Neighbourhood identifier.
    ///     - policeForceID: Police Force identifier.
    ///     - completion: Completion handler.
    ///     - result: A list of police officers who are members of the neighbourhood team for the matching neighbourhood.
    func fetchPoliceOfficers(forNeighbourhood neighbourhoodID: String, inPoliceForce policeForceID: String,
                             completion: @escaping (_ result: Result<[PoliceOfficer], PoliceDataError>) -> Void)

    /// Fetches a list priorities for a neighbourhood.
    ///
    /// - Note: [Police API | Neighbourhood priorities](https://data.police.uk/docs/method/neighbourhood-priorities/)
    ///
    /// - Parameters:
    ///     - neighbourhoodID: Neighbourhood identifier.
    ///     - policeForceID: Police Force identifier.
    ///     - completion: Completion handler.
    ///     - result: A list of priorities for the matching neighbourhood.
    func fetchPriorities(forNeighbourhood neighbourhoodID: String, inPoliceForce policeForceID: String,
                         completion: @escaping (_ result: Result<[NeighbourhoodPriority], PoliceDataError>) -> Void)

    /// Fetches the neighbourhood policing team responsible for a particular area.
    ///
    /// - Note: [Police API | Locate a neighbourhood](https://data.police.uk/docs/method/neighbourhood-locate/)
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///     - completion: Completion handler.
    ///     - result: The neighbourhood policing team for a location.
    func fetchNeighbourhoodPolicingTeam(
        atCoordinate coordinate: Coordinate,
        completion: @escaping (_ result: Result<NeighbourhoodPolicingTeam, PoliceDataError>) -> Void)

    #if canImport(Combine)
    /// Publishes a list of all the neighbourhoods in a police force.
    ///
    /// - Note: [Police API | List of neighbourhoods for a force](https://data.police.uk/docs/method/neighbourhoods/)
    ///
    /// - Parameters:
    ///     - policeForceID: Police Force identifier.
    ///
    /// - Returns: A publisher with a list of Neighbourhoods.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func neighbourhoodsPublisher(
        inPoliceForce policeForceID: String) -> AnyPublisher<[NeighbourhoodReference], PoliceDataError>

    /// Publishes details of a neighbourhood in a police force.
    ///
    /// - Note: [Police API | Specific neighbourhood](https://data.police.uk/docs/method/neighbourhood/)
    ///
    /// - Parameters:
    ///     - id: Neighbourhood identifier.
    ///     - policeForceID: Police Force identifier.
    ///
    /// - Returns: A publisher with the matching Neighbourhood.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func detailsPublisher(forNeighbourhood id: String,
                          inPoliceForce policeForceID: String) -> AnyPublisher<Neighbourhood, PoliceDataError>

    /// Publishes a list of coordinates that make up the boundary of a neighbourhood.
    ///
    /// - Note: [Police API | Neighbourhood boundary](https://data.police.uk/docs/method/neighbourhood-boundary/)
    ///
    /// - Parameters:
    ///     - neighbourhoodID: Neighbourhood identifier.
    ///     - policeForceID: Police Force identifier.
    ///
    /// - Returns: A publisher with a list of coordinates that make up the boundary of the matching neighbourhood.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func boundaryPublisher(forNeighbourhood neighbourhoodID: String,
                           inPoliceForce policeForceID: String) -> AnyPublisher<[Coordinate], PoliceDataError>

    /// Publishes a list of Police Officers who are members of the neighbourhood team for a neighbourhood.
    ///
    /// - Note: [Police API | Neighbourhood team](https://data.police.uk/docs/method/neighbourhood-team/)
    ///
    /// - Parameters:
    ///     - neighbourhoodID: Neighbourhood identifier.
    ///     - policeForceID: Police Force identifier.
    /// - Returns: A publisher with a list of police officers who are members of the neighbourhood team for the matching neighbourhood.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func policeOfficersPublisher(forNeighbourhood neighbourhoodID: String,
                                 inPoliceForce policeForceID: String) -> AnyPublisher<[PoliceOfficer], PoliceDataError>

    /// Publishes a list of Priorities for a neighbourhood.
    ///
    /// - Note: [Police API | Neighbourhood priorities](https://data.police.uk/docs/method/neighbourhood-priorities/)
    ///
    /// - Parameters:
    ///     - neighbourhoodID: Neighbourhood identifier.
    ///     - policeForceID: Police Force identifier.
    /// - Returns: A publisher with a list of police officers who are members of the neighbourhood team for the matching neighbourhood.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func prioritiesPublisher(
        forNeighbourhood neighbourhoodID: String,
        inPoliceForce policeForceID: String) -> AnyPublisher<[NeighbourhoodPriority], PoliceDataError>

    /// Publishes the neighbourhood policing team responsible for a particular area.
    ///
    /// - Note: [Police API | Locate a neighbourhood](https://data.police.uk/docs/method/neighbourhood-locate/)
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///
    /// - Returns: A publisher with the neighbourhood policing team for a location.
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func neighbourhoodPolicingTeamPublisher(
        atCoordinate coordinate: Coordinate) -> AnyPublisher<NeighbourhoodPolicingTeam, PoliceDataError>
    #endif

}

#if swift(>=5.5)
@available(macOS 12, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
public extension NeighbourhoodService {

    /// Returns a list of all the neighbourhoods in a police force.
    ///
    /// - Note: [Police API | List of neighbourhoods for a force](https://data.police.uk/docs/method/neighbourhoods/)
    ///
    /// - Parameters:
    ///     - policeForceID: Police Force identifier.
    ///
    /// - Returns: A list of Neighbourhoods.
    func all(inPoliceForce policeForceID: String) async throws -> [NeighbourhoodReference] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchAll(inPoliceForce: policeForceID, completion: continuation.resume(with:))
        }
    }

    /// Returns details of a neighbourhood in a police force.
    ///
    /// - Note: [Police API | Specific neighbourhood](https://data.police.uk/docs/method/neighbourhood/)
    ///
    /// - Parameters:
    ///     - id: Neighbourhood identifier.
    ///     - policeForceID: Police Force identifier.
    ///
    /// - Returns: The matching Neighbourhood.
    func details(forNeighbourhood id: String, inPoliceForce policeForceID: String) async throws -> Neighbourhood {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchDetails(forNeighbourhood: id, inPoliceForce: policeForceID,
                              completion: continuation.resume(with:))
        }
    }

    /// Returns a list of coordinates that make up the boundary of a neighbourhood.
    ///
    /// - Note: [Police API | Neighbourhood boundary](https://data.police.uk/docs/method/neighbourhood-boundary/)
    ///
    /// - Parameters:
    ///     - neighbourhoodID: Neighbourhood identifier.
    ///     - policeForceID: Police Force identifier.
    ///
    /// - Returns: A list of coordinates that make up the boundary of the matching neighbourhood.
    func boundary(forNeighbourhood neighbourhoodID: String,
                  inPoliceForce policeForceID: String) async throws -> [Coordinate] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchBoundary(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID,
                               completion: continuation.resume(with:))
        }
    }

    /// Returns a list of Police Officers who are members of the neighbourhood team for a neighbourhood.
    ///
    /// - Note: [Police API | Neighbourhood team](https://data.police.uk/docs/method/neighbourhood-team/)
    ///
    /// - Parameters:
    ///     - neighbourhoodID: Neighbourhood identifier.
    ///     - policeForceID: Police Force identifier.
    ///
    /// - Returns: A list of police officers who are members of the neighbourhood team for the matching neighbourhood.
    func policeOfficers(forNeighbourhood neighbourhoodID: String,
                        inPoliceForce policeForceID: String) async throws -> [PoliceOfficer] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchPoliceOfficers(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID,
                                     completion: continuation.resume(with:))
        }
    }

    /// Returns a list priorities for a neighbourhood.
    ///
    /// - Note: [Police API | Neighbourhood priorities](https://data.police.uk/docs/method/neighbourhood-priorities/)
    ///
    /// - Parameters:
    ///     - neighbourhoodID: Neighbourhood identifier.
    ///     - policeForceID: Police Force identifier.
    ///
    /// - Returns: A list of priorities for the matching neighbourhood.
    func priorities(forNeighbourhood neighbourhoodID: String,
                    inPoliceForce policeForceID: String) async throws -> [NeighbourhoodPriority] {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchPriorities(forNeighbourhood: neighbourhoodID, inPoliceForce: policeForceID,
                                 completion: continuation.resume(with:))
        }
    }

    /// Returns the neighbourhood policing team responsible for a particular area.
    ///
    /// - Note: [Police API | Locate a neighbourhood](https://data.police.uk/docs/method/neighbourhood-locate/)
    ///
    /// - Parameters:
    ///     - coordinate: A coordinate.
    ///
    /// - Returns: The neighbourhood policing team for a location.
    func neighbourhoodPolicingTeam(atCoordinate coordinate: Coordinate) async throws -> NeighbourhoodPolicingTeam {
        try await withCheckedThrowingContinuation { continuation in
            self.fetchNeighbourhoodPolicingTeam(atCoordinate: coordinate, completion: continuation.resume(with:))
        }
    }

}
#endif
