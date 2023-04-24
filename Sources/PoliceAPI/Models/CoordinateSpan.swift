import Foundation

public struct CoordinateSpan {

    public let latitudeDelta: Double
    public let longitudeDelta: Double

    public init(latitudeDelta: Double, longitudeDelta: Double) {
        self.latitudeDelta = latitudeDelta
        self.longitudeDelta = longitudeDelta
    }

}
