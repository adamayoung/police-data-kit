import Foundation

final class UKStopAndSearchService: StopAndSearchService {

    private let apiClient: any APIClient

    init(apiClient: some APIClient) {
        self.apiClient = apiClient
    }

    func stopAndSearches(atCoordinate coordinate: Coordinate, date: Date?) async throws -> [StopAndSearch] {
        try await apiClient.get(
            endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaAtSpecificPoint(coordinate: coordinate, date: date)
        )
    }

    func stopAndSearches(inArea boundary: Boundary, date: Date?) async throws -> [StopAndSearch] {
        try await apiClient.get(
            endpoint: StopAndSearchesEndpoint.stopAndSearchesByAreaInArea(boundary: boundary, date: date)
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
