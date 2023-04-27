import Foundation
import MapKit

extension MKCoordinateRegion {

    static var test: Self {
        .init(
            center: .init(
                latitude: 54.4661645479556,
                longitude: -3.1076525162671667
            ),
            span: .init(
                latitudeDelta: 13.0738,
                longitudeDelta: 11.4748
            )
        )
    }

}
