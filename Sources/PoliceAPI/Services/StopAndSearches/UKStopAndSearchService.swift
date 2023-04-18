import Foundation

final class UKStopAndSearchService: StopAndSearchService {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    func stopAndSearches(atCoordinate coordinate: Coordinate, date: Date?) async throws -> [StopAndSearch] {
        try await apiClient.get(
            endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate, date: date)
        )
    }

    func stopAndSearches(inArea coordinates: [Coordinate], date: Date?) async throws -> [StopAndSearch] {
        try await apiClient.get(
            endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(coordinates: coordinates, date: date)
        )
    }

    func stopAndSearches(atLocation streetID: Int, date: Date?) async throws -> [StopAndSearch] {
        try await apiClient.get(
            endpoint: StopAndSearchesEndpoint.stopAndSearchesAtLocation(streetID: streetID, date: date)
        )
    }

    func stopAndSearchesWithNoLocation(forPoliceForce policeForceID: String,
                                       date: Date?) async throws -> [StopAndSearch] {
        try await apiClient.get(
            endpoint: StopAndSearchesEndpoint.stopAndSearchesWithNoLocation(policeForceID: policeForceID, date: date)
        )
    }

    func stopAndSearches(forPoliceForce policeForceID: String, date: Date?) async throws -> [StopAndSearch] {
        try await apiClient.get(
            endpoint: StopAndSearchesEndpoint.stopAndSearchesByPoliceForce(policeForceID: policeForceID, date: date)
        )
    }

}
