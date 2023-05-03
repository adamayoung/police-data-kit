import Foundation
import MapKit

extension MKCoordinateRegion {

    public static var availableDataRegion: Self {
        .uk
    }

    static var uk: Self {
        .init(
            center: CLLocationCoordinate2D(
                latitude: 54.4661645479556,
                longitude: -3.1076525162671667
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 13.0738,
                longitudeDelta: 11.4748
            )
        )
    }

}
