import Foundation
#if canImport(MapKit)
import MapKit
#endif

extension CoordinateRegion {

    public func contains(coordinate: Coordinate, margin: Double = 0.01) -> Bool {
        let northWestCoordinate = self.northWestCoordinate
        let southEastRightCoordinate = self.southEastRightCoordinate

        return coordinate.latitude >= northWestCoordinate.latitude - margin
            && coordinate.longitude >= northWestCoordinate.longitude - margin
            && coordinate.latitude <= southEastRightCoordinate.latitude + margin
            && coordinate.longitude <= southEastRightCoordinate.longitude + margin
    }

}

#if canImport(MapKit)
extension MKCoordinateRegion {

    public func contains(coordinate clCoordinate: CLLocationCoordinate2D, margin: Double = 0.01) -> Bool {
        let region = self.policeAPICoordinateRegion
        let coordinate = clCoordinate.policeAPICoordinate

        return region.contains(coordinate: coordinate)
    }

}
#endif

extension CoordinateRegion {

    private var northWestCoordinate: Coordinate {
        Coordinate(
            latitude: center.latitude - (span.latitudeDelta / 2),
            longitude: center.longitude - (span.longitudeDelta / 2)
        )
    }

    private var southEastRightCoordinate: Coordinate {
        Coordinate(
            latitude: center.latitude + (span.latitudeDelta / 2.0),
            longitude: center.longitude + (span.longitudeDelta / 2.0)
        )
    }

}
