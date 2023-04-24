#if canImport(MapKit)
import Foundation
import MapKit

extension CoordinateRegion {

    public var mkCoordinateRegion: MKCoordinateRegion {
        .init(center: center.clCoordinate, span: span.mkCoordinateSpan)
    }

}

extension MKCoordinateRegion {

    public var policeAPICoordinateRegion: CoordinateRegion {
        CoordinateRegion(
            center: center.policeAPICoordinate,
            span: span.policeAPICoordinateSpan
        )
    }

}
#endif
