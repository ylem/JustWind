import Foundation

struct WeatherResponse: Decodable {
    
    let cod: Int
    let dt: UInt64
    let coord: GeoCoordinator
    let weather: [Weather]
    let main: Main
    let wind: Wind
}
