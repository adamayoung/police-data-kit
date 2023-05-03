import Foundation
@testable import PoliceDataKit

extension NeighbourhoodReference {

    static var mock: Self {
        NeighbourhoodReference(
            id: "NC04",
            name: "City Centre"
        )
    }

    static var mocks: [Self] {
        [
            .mock,
            NeighbourhoodReference(
                id: "NC66",
                name: "Cultural Quarter"
            ),
            NeighbourhoodReference(
                id: "NC67",
                name: "Riverside"
            ),
            NeighbourhoodReference(
                id: "NC68",
                name: "Clarendon Park"
            )
        ]
    }

}
