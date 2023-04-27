import Foundation

enum StopAndSearchTypeDataModel: String, Decodable {

    case personSearch = "Person search"
    case vehicleSearch = "Vehicle search"
    case personAndVehicleSearch = "Person and Vehicle search"

}
