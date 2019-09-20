import Foundation

struct GeoCoordinator: Decodable {
    
    let lon: Double
    let lat: Double
    
    var description: String {
        return "\(lat), \(lon)"
    }
}
