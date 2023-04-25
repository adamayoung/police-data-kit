import Foundation

extension CoordinateRegionDataModel {

    static var availableDataRegion: Self {
        .uk
    }

    static var uk: Self {
        .init(
            center: CoordinateDataModel(
                latitude: 54.4661645479556,
                longitude: -3.1076525162671667
            ),
            span: CoordinateSpanDataModel(
                latitudeDelta: 13.0738,
                longitudeDelta: 11.4748
            )
        )
    }

}
