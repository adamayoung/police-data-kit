import Foundation

extension StopAndSearchType {

    init(dataModel: StopAndSearchTypeDataModel) {
        switch dataModel {
        case .personSearch:
            self = .personSearch

        case .vehicleSearch:
            self = .vehicleSearch

        case .personAndVehicleSearch:
            self = .personAndVehicleSearch
        }
    }

}
