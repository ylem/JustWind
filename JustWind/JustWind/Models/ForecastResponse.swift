import Foundation

struct ForecastResponse: Decodable {
    
    let cod: String
    let cnt: Int
    let list: [ForecastWeatherResponse]
}

struct ForecastWeatherResponse: Decodable {
    
    let dt: UInt64
    let main: Main
    let weather: [Weather]
    let wind: Wind
    
    var date: String {
        return Date(timeIntervalSince1970: TimeInterval(dt)).toString(formatString: "dd/MM/yyyy HH:mm")
    }
}
