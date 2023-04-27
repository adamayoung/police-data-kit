import Foundation
@testable import PoliceDataKit

extension NeighbourhoodReferenceDataModel {

    static var mock: Self {
        NeighbourhoodReferenceDataModel(
            id: "NC04",
            name: "City Centre"
        )
    }

    static var mocks: [Self] {
        [
            .mock,
            NeighbourhoodReferenceDataModel(
                id: "NC66",
                name: "Cultural Quarter"
            ),
            NeighbourhoodReferenceDataModel(
                id: "NC67",
                name: "Riverside"
            ),
            NeighbourhoodReferenceDataModel(
                id: "NC68",
                name: "Clarendon Park"
            )
        ]
    }

}
