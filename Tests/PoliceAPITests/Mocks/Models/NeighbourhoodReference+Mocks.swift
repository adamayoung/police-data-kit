import Foundation
import PoliceAPI

extension NeighbourhoodReference {

    static var mock: NeighbourhoodReference {
        NeighbourhoodReference(
            id: "NC04",
            name: "City Centre"
        )
    }

    static var mocks: [NeighbourhoodReference] {
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
