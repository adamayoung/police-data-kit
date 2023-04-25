import Foundation

struct CoordinateSpanDataModel {

    let latitudeDelta: Double
    let longitudeDelta: Double

    init(latitudeDelta: Double, longitudeDelta: Double) {
        self.latitudeDelta = latitudeDelta
        self.longitudeDelta = longitudeDelta
    }

}
