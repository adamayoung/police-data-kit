import Foundation

final class UKCrimeService: CrimeService {

    private let apiClient: any APIClient

    init(apiClient: some APIClient) {
        self.apiClient = apiClient
    }

    func streetLevelCrimes(atCoordinate coordinate: Coordinate, date: Date?) async throws -> [Crime] {
        try await apiClient.get(
            endpoint: CrimesEndpoint.streetLevelCrimesAtSpecificPoint(coordinate: coordinate, date: date)
        )
    }

    func streetLevelCrimes(inArea boundary: Boundary, date: Date?) async throws -> [Crime] {
        try await apiClient.get(endpoint: CrimesEndpoint.streetLevelCrimesInArea(boundary: boundary, date: date))
    }

    func crimes(forStreet streetID: Int, date: Date?) async throws -> [Crime] {
        try await apiClient.get(endpoint: CrimesEndpoint.crimesAtLocationForStreet(streetID: streetID, date: date))
    }

    func crimes(atCoordinate coordinate: Coordinate, date: Date?) async throws -> [Crime] {
        try await apiClient.get(
            endpoint: CrimesEndpoint.crimesAtLocationAtSpecificPoint(coordinate: coordinate, date: date)
        )
    }

    func crimesWithNoLocation(forCategory categoryID: CrimeCategory.ID, inPoliceForce policeForceID: PoliceForce.ID,
                              date: Date?) async throws -> [Crime] {
        try await apiClient.get(
            endpoint: CrimesEndpoint.crimesWithNoLocation(
                categoryID: categoryID, policeForceID: policeForceID, date: date
            )
        )
    }

    func crimeCategories(forDate date: Date) async throws -> [CrimeCategory] {
        try await apiClient.get(endpoint: CrimesEndpoint.categories(date: date))
    }

}
