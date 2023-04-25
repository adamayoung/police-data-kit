import Foundation
import PoliceAPIDomain

extension CrimeLocationType {

    init(dataModel: CrimeLocationTypeDataModel) {
        switch dataModel {
        case .force:
            self = .force

        case .btp:
            self = .britishTransportPolice
        }
    }

}
