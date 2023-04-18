import Foundation

public enum StopAndSearchType: String, Decodable, CaseIterable, CustomStringConvertible {

    case personSearch = "Person search"
    case vehicleSearch = "Vehicle search"
    case personAndVehicleSearch = "Person and Vehicle search"

    public var description: String {
        rawValue
    }

}
