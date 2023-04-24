import Foundation

extension CoordinateRegion {

    public func contains(coordinate: Coordinate) -> Bool {
        let northWestCoordinate = self.northWestCoordinate
        let southEastRightCoordinate = self.southEastRightCoordinate

        return coordinate.latitude >= northWestCoordinate.latitude
            && coordinate.longitude >= northWestCoordinate.longitude
            && coordinate.latitude <= southEastRightCoordinate.latitude
            && coordinate.longitude <= southEastRightCoordinate.longitude
    }

}

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
