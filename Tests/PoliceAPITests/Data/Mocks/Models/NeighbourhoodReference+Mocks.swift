import Foundation
@testable import PoliceAPI

extension NeighbourhoodReferenceDataModel {

    static var mock: NeighbourhoodReferenceDataModel {
        NeighbourhoodReferenceDataModel(
            id: "NC04",
            name: "City Centre"
        )
    }

    static var mocks: [NeighbourhoodReferenceDataModel] {
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
