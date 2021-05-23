import Foundation

#if canImport(Combine)
import Combine
#endif

final class UKOutcomeService: OutcomeService {

    private let apiClient: APIClient

    init(apiClient: APIClient = PoliceDataAPIClient.shared) {
        self.apiClient = apiClient
    }

    func fetchStreetLevelOutcomes(forStreet streetID: Int, date: Date?,
                                  completion: @escaping (_ result: Result<[Outcome], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date),
                      completion: completion)
    }

    func fetchStreetLevelOutcomes(atCoordinate coordinate: Coordinate, date: Date?,
                                  completion: @escaping (_ result: Result<[Outcome], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date),
                      completion: completion)
    }

    func fetchStreetLevelOutcomes(inArea coordinates: [Coordinate], date: Date?,
                                  completion: @escaping (_ result: Result<[Outcome], PoliceDataError>) -> Void) {
        apiClient.get(endpoint: OutcomesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date),
                      completion: completion)
    }

    func fetchCaseHistory(forCrime crimeID: String,
                          completion: @escaping (_ result: Result<CaseHistory, PoliceDataError>) -> Void) {
        apiClient.get(endpoint: OutcomesEndpoint.caseHistory(crimeID: crimeID), completion: completion)
    }

}

#if canImport(Combine)
extension UKOutcomeService {

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelOutcomesPublisher(forStreet streetID: Int,
                                      date: Date?) -> AnyPublisher<[Outcome], PoliceDataError> {
        apiClient.get(endpoint: OutcomesEndpoint.streetLevelOutcomesForStreet(streetID: streetID, date: date))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelOutcomesPublisher(atCoordinate coordinate: Coordinate,
                                      date: Date?) -> AnyPublisher<[Outcome], PoliceDataError> {
        apiClient.get(endpoint: OutcomesEndpoint.streetLevelOutcomesAtSpecificPoint(coordinate: coordinate, date: date))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func caseHistoryPublisher(forCrime crimeID: String) -> AnyPublisher<CaseHistory, PoliceDataError> {
        apiClient.get(endpoint: OutcomesEndpoint.caseHistory(crimeID: crimeID))
    }

    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    func streetLevelOutcomesPublisher(inArea coordinates: [Coordinate],
                                      date: Date?) -> AnyPublisher<[Outcome], PoliceDataError> {
        apiClient.get(endpoint: OutcomesEndpoint.streetLevelOutcomesInArea(coordinates: coordinates, date: date))
    }

}
#endif
