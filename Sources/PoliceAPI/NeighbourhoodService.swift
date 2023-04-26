import CoreLocation
import Foundation

///
/// Provides an interface for obtaining neighbour data from the UK Police Data API.
///
public final class NeighbourhoodService {

    ///
    /// A single, shared neighbourhood service object.
    ///
    /// Use this object to interface to neighbourhood services in your application.
    ///
    public static let shared = NeighbourhoodService()

    private let neighbourhoodRepository: any NeighbourhoodRepository

    ///
    /// Creates a neighbourhood service object.
    ///
    /// Use this method to create different `NeighbourhoodService` instances. If you only need one instance of
    /// `NeighbourhoodService`, use `shared`.
    ///
    public convenience init() {
        self.init(neighbourhoodRepository: PoliceAPIFactory.neighbourhoodRepository())
    }

    init(neighbourhoodRepository: some NeighbourhoodRepository) {
        self.neighbourhoodRepository = neighbourhoodRepository
    }

    ///
    /// Returns a list of all the neighbourhoods in a police force.
    ///
    /// [https://data.police.uk/docs/method/neighbourhoods/](https://data.police.uk/docs/method/neighbourhoods/)
    ///
    /// - Parameter policeForceID: Police force identifier.
    ///
    /// - Throws: Neighbourhood data error `NeighbourhoodError`.
    ///
    /// - Returns: The neighbourhoods in the specified police force.
    ///
    public func neighbourhoods(inPoliceForce policeForceID: PoliceForce.ID) async throws -> [NeighbourhoodReference] {
        let neighbourhoods = try await neighbourhoodRepository.neighbourhoods(inPoliceForce: policeForceID)

        return neighbourhoods
    }

    ///
    /// Returns details of a neighbourhood in a police force.
    ///
    /// [https://data.police.uk/docs/method/neighbourhood/](https://data.police.uk/docs/method/neighbourhood/)
    ///
    /// - Parameters:
    ///   - id: Neighbourhood identifier.
    ///   - policeForceID: Police Force identifier.
    ///
    /// - Throws: Neighbourhood data error `NeighbourhoodError`.
    ///
    /// - Returns: The neighbourhood matching the specified ID and police force.
    ///
    public func neighbourhood(withID id: Neighbourhood.ID,
                              inPoliceForce policeForceID: PoliceForce.ID) async throws -> Neighbourhood? {
        let neighbourhood = try await neighbourhoodRepository.neighbourhood(withID: id, inPoliceForce: policeForceID)

        return neighbourhood
    }

    ///
    /// Returns a list of coordinates that make up the boundary of a neighbourhood.
    ///
    /// [https://data.police.uk/docs/method/neighbourhood-boundary/](https://data.police.uk/docs/method/neighbourhood-boundary/)
    ///
    /// - Parameters:
    ///   - neighbourhoodID: Neighbourhood identifier.
    ///   - policeForceID: Police Force identifier.
    ///
    /// - Throws: Neighbourhood data error `NeighbourhoodError`.
    ///
    /// - Returns: The coordinates that make up the boundary of the matching neighbourhood.
    ///
    public func boundary(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                         inPoliceForce policeForceID: PoliceForce.ID) async throws -> [CLLocationCoordinate2D]? {
        let boundary = try await neighbourhoodRepository.boundary(forNeighbourhood: neighbourhoodID,
                                                                  inPoliceForce: policeForceID)

        return boundary
    }

    ///
    /// Returns a list of Police Officers who are members of the neighbourhood team for a neighbourhood.
    ///
    /// [https://data.police.uk/docs/method/neighbourhood-team/](https://data.police.uk/docs/method/neighbourhood-team/)
    ///
    /// - Parameters:
    ///   - neighbourhoodID: Neighbourhood identifier.
    ///   - policeForceID: Police Force identifier.
    ///
    /// - Throws: Neighbourhood data error `NeighbourhoodError`.
    ///
    /// - Returns: Police officers who are members of the neighbourhood team for the specified neighbourhood and police force.
    ///
    public func policeOfficers(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                               inPoliceForce policeForceID: PoliceForce.ID) async throws -> [PoliceOfficer] {
        let policeOfficers = try await neighbourhoodRepository.policeOfficers(forNeighbourhood: neighbourhoodID,
                                                                              inPoliceForce: policeForceID)

        return policeOfficers
    }

    ///
    /// Returns a list priorities for a neighbourhood.
    ///
    /// [https://data.police.uk/docs/method/neighbourhood-priorities/](https://data.police.uk/docs/method/neighbourhood-priorities/)
    ///
    /// - Parameters:
    ///   - neighbourhoodID: Neighbourhood identifier.
    ///   - policeForceID: Police Force identifier.
    ///
    /// - Throws: Neighbourhood data error `NeighbourhoodError`.
    ///
    /// - Returns: The neighbourhood priorities for the specified neighbourhood and police force.
    /// 
    public func priorities(forNeighbourhood neighbourhoodID: Neighbourhood.ID,
                           inPoliceForce policeForceID: PoliceForce.ID) async throws -> [NeighbourhoodPriority] {
        let priorities = try await neighbourhoodRepository.priorities(forNeighbourhood: neighbourhoodID,
                                                                      inPoliceForce: policeForceID)

        return priorities
    }

    ///
    /// Returns the neighbourhood policing team responsible for a particular area.
    ///
    /// [https://data.police.uk/docs/method/neighbourhood-locate/](https://data.police.uk/docs/method/neighbourhood-locate/)
    ///
    /// - Parameter coordinate: A coordinate.
    ///
    /// - Throws: Neighbourhood data error `NeighbourhoodError`.
    ///
    /// - Returns: The neighbourhood policing team the specificed location.
    ///
    public func neighbourhoodPolicingTeam(
        at coordinate: CLLocationCoordinate2D
    ) async throws -> NeighbourhoodPolicingTeam? {
        let policingTeam = try await neighbourhoodRepository.neighbourhoodPolicingTeam(at: coordinate)

        return policingTeam
    }

}
