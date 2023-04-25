import Foundation

extension CoordinateRegion {

    public static var availableDataRegion: Self {
        .uk
    }

    static var uk: Self {
        .init(
            center: Coordinate(
                latitude: 54.4661645479556,
                longitude: -3.1076525162671667
            ),
            span: CoordinateSpan(
                latitudeDelta: 13.0738,
                longitudeDelta: 11.4748
            )
        )
    }

}
