import Foundation

extension CrimeLocationType {

    init(dataModel: CrimeLocationTypeDataModel) {
        switch dataModel {
        case .force:
            self = .force

        case .britishTransportPolice:
            self = .britishTransportPolice
        }
    }

}
