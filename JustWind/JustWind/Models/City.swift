import Foundation

struct City: Decodable {
    
    let id: Int
    let coord: GeoCoordinator
    let sys: Sys
    let name: String
}

extension City {
    
    var coutryCode: String {
        return sys.country
    }
}
