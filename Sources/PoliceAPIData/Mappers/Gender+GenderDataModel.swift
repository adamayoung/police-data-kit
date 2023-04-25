import Foundation
import PoliceAPIDomain

extension Gender {

    init(dataModel: GenderDataModel) {
        switch dataModel {
        case .male:
            self = .male

        case .female:
            self = .female
        }
    }

}
