import Foundation

extension CoordinateRegionDataModel {

    func contains(coordinate: CoordinateDataModel) -> Bool {
        let northWestCoordinate = self.northWestCoordinate
        let southEastRightCoordinate = self.southEastRightCoordinate

        return coordinate.latitude >= northWestCoordinate.latitude
            && coordinate.longitude >= northWestCoordinate.longitude
            && coordinate.latitude <= southEastRightCoordinate.latitude
            && coordinate.longitude <= southEastRightCoordinate.longitude
    }

}

extension CoordinateRegionDataModel {

    private var northWestCoordinate: CoordinateDataModel {
        CoordinateDataModel(
            latitude: center.latitude - (span.latitudeDelta / 2),
            longitude: center.longitude - (span.longitudeDelta / 2)
        )
    }

    private var southEastRightCoordinate: CoordinateDataModel {
        CoordinateDataModel(
            latitude: center.latitude + (span.latitudeDelta / 2.0),
            longitude: center.longitude + (span.longitudeDelta / 2.0)
        )
    }

}
