import Foundation
@testable import PoliceDataKit

extension PoliceForceReference {

    static var mock: Self {
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
