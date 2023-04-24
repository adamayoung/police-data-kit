#if canImport(MapKit)
import Foundation
import MapKit

extension CoordinateSpan {

    public var mkCoordinateSpan: MKCoordinateSpan {
        .init(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
    }

}

extension MKCoordinateSpan {

    public var policeAPICoordinateSpan: CoordinateSpan {
        .init(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
    }

}
#endif
