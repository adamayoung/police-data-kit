import Foundation
@testable import PoliceAPIData

extension NeighbourhoodLocationDataModel {

    static var mock: NeighbourhoodLocationDataModel {
        NeighbourhoodLocationDataModel(
            name: "Mansfield House",
            type: "station",
            address: "74 Belgrave Gate\n, Leicester",
            postcode: "LE1 3GG",
            latitude: 52.6389,
            longitude: -1.13619
        )
    }

}
