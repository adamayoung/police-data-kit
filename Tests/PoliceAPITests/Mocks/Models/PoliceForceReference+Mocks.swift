import Foundation
import PoliceAPI

extension PoliceForceReference {

    static var mock: PoliceForceReference {
        PoliceForceReference(
            id: "avon-and-somerset",
            name: "Avon and Somerset Constabulary"
        )
    }

    static var mocks: [PoliceForceReference] {
        [
            .mock,
            PoliceForceReference(
                id: "bedfordshire",
                name: "Bedfordshire Police"
            ),
            PoliceForceReference(
                id: "cambridgeshire",
                name: "Cambridgeshire Constabulary"
            )
        ]
    }

}
