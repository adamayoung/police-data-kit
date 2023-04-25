import Foundation

public struct CoordinateRegion {

    public let center: Coordinate
    public let span: CoordinateSpan

    public init(center: Coordinate, span: CoordinateSpan) {
        self.center = center
        self.span = span
    }

}
