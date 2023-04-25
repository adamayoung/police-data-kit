import Foundation

/// Get information about a Police Force Neighbourhoods.
protocol NeighbourhoodRepository {

    /// Returns a list of all the neighbourhoods in a police force.
    ///
    /// - Note: [Police API | List of neighbourhoods for a force](https://data.police.uk/docs/method/neighbourhoods/)
    ///
    /// - Parameters:
    ///   - policeForceID: Police Force identifier.
    ///
    /// - Returns: A list of Neighbourhoods.
    func neighbourhoods(inPoliceForce policeForceID: PoliceForceDataModel.ID) async throws -> [NeighbourhoodReferenceDataModel]

    /// Returns details of a neighbourhood in a police force.
    ///
    /// - Note: [Police API | Specific neighbourhood](https://data.police.uk/docs/method/neighbourhood/)
    ///
    /// - Parameters:
    ///   - id: Neighbourhood identifier.
    ///   - policeForceID: Police Force identifier.
    ///
    /// - Returns: The matching Neighbourhood.
    func neighbourhood(withID id: NeighbourhoodDataModel.ID,
                       inPoliceForce policeForceID: PoliceForceDataModel.ID) async throws -> NeighbourhoodDataModel?

    /// Returns a list of coordinates that make up the boundary of a neighbourhood.
    ///
    /// - Note: [Police API | Neighbourhood boundary](https://data.police.uk/docs/method/neighbourhood-boundary/)
    ///
    /// - Parameters:
    ///   - neighbourhoodID: Neighbourhood identifier.
    ///   - policeForceID: Police Force identifier.
    ///
    /// - Returns: A list of coordinates that make up the boundary of the matching neighbourhood.
    func boundary(forNeighbourhood neighbourhoodID: NeighbourhoodDataModel.ID,
                  inPoliceForce policeForceID: PoliceForceDataModel.ID) async throws -> BoundaryDataModel?

    /// Returns a list of Police Officers who are members of the neighbourhood team for a neighbourhood.
    ///
    /// - Note: [Police API | Neighbourhood team](https://data.police.uk/docs/method/neighbourhood-team/)
    ///
    /// - Parameters:
    ///   - neighbourhoodID: Neighbourhood identifier.
    ///   - policeForceID: Police Force identifier.
    ///
    /// - Returns: A list of police officers who are members of the neighbourhood team for the matching neighbourhood.
    func policeOfficers(forNeighbourhood neighbourhoodID: NeighbourhoodDataModel.ID,
                        inPoliceForce policeForceID: PoliceForceDataModel.ID) async throws -> [PoliceOfficerDataModel]

    /// Returns a list priorities for a neighbourhood.
    ///
    /// - Note: [Police API | Neighbourhood priorities](https://data.police.uk/docs/method/neighbourhood-priorities/)
    ///
    /// - Parameters:
    ///   - neighbourhoodID: Neighbourhood identifier.
    ///   - policeForceID: Police Force identifier.
    ///
    /// - Returns: A list of priorities for the matching neighbourhood.
    func priorities(forNeighbourhood neighbourhoodID: NeighbourhoodDataModel.ID,
                    inPoliceForce policeForceID: PoliceForceDataModel.ID) async throws -> [NeighbourhoodPriorityDataModel]

    /// Returns the neighbourhood policing team responsible for a particular area.
    ///
    /// - Note: [Police API | Locate a neighbourhood](https://data.police.uk/docs/method/neighbourhood-locate/)
    ///
    /// - Parameters:
    ///   - coordinate: A coordinate.
    ///
    /// - Returns: The neighbourhood policing team for a location.
    func neighbourhoodPolicingTeam(atCoordinate coordinate: CoordinateDataModel) async throws -> NeighbourhoodPolicingTeamDataModel?

}

protocol NeighbourhoodRepositoryProviding {

    var neighbourhoodRepository: NeighbourhoodRepository { get}

}
