import Foundation

struct SearchCityResponse: Decodable {
    
    let cod: String
    let count: Int
    let list: [City]
}
