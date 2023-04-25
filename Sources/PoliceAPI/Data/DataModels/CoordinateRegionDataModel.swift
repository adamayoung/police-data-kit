import Foundation

struct CoordinateRegionDataModel {

    let center: CoordinateDataModel
    let span: CoordinateSpanDataModel

    init(center: CoordinateDataModel, span: CoordinateSpanDataModel) {
        self.center = center
        self.span = span
    }

}
