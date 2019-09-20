import Foundation

struct WeatherGroupResponse: Decodable {
    
    let cnt: Int
    let list: [WeatherResponse]
}
