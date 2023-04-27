import Foundation
@testable import PoliceAPI

extension PoliceForceReferenceDataModel {

    static var mock: Self {
        PoliceForceReferenceDataModel(
            id: "avon-and-somerset",
            name: "Avon and Somerset Constabulary"
        )
    }

    static var mocks: [PoliceForceReferenceDataModel] {
        [
            .mock,
            PoliceForceReferenceDataModel(
                id: "bedfordshire",
                name: "Bedfordshire Police"
            ),
            PoliceForceReferenceDataModel(
                id: "cambridgeshire",
                name: "Cambridgeshire Constabulary"
            )
        ]
    }

}
