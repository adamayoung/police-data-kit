import Foundation
import MapKit

extension MKCoordinateRegion {

    public func contains(coordinate: CLLocationCoordinate2D) -> Bool {
        let northWestCoordinate = self.northWestCoordinate
        let southEastRightCoordinate = self.southEastRightCoordinate

        return coordinate.latitude >= northWestCoordinate.latitude
            && coordinate.longitude >= northWestCoordinate.longitude
            && coordinate.latitude <= southEastRightCoordinate.latitude
            && coordinate.longitude <= southEastRightCoordinate.longitude
    }

}

extension MKCoordinateRegion {

    private var northWestCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: center.latitude - (span.latitudeDelta / 2.0),
            longitude: center.longitude - (span.longitudeDelta / 2.0)
        )
    }

    private var southEastRightCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: center.latitude + (span.latitudeDelta / 2.0),
            longitude: center.longitude + (span.longitudeDelta / 2.0)
        )
    }

}
