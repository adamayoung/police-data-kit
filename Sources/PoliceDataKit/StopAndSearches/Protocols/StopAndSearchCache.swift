import Foundation

protocol StopAndSearchCache {

    func stopAndSearches(atLocation streetID: Int, date: Date) async -> [StopAndSearch]?

    func setStopAndSearches(_ stopAndSearches: [StopAndSearch], atLocation streetID: Int,
                            date: Date) async

    func stopAndSearchesWithNoLocation(forPoliceForce policeForceID: PoliceForce.ID,
                                       date: Date) async -> [StopAndSearch]?

    func setStopAndSearchesWithNoLocation(_ stopAndSearches: [StopAndSearch],
                                          forPoliceForce policeForceID: PoliceForce.ID, date: Date) async

    func stopAndSearches(forPoliceForce policeForceID: PoliceForce.ID, date: Date) async -> [StopAndSearch]?

    func setStopAndSearches(_ stopAndSearches: [StopAndSearch], forPoliceForce policeForceID: PoliceForce.ID,
                            date: Date) async

}
