import Foundation

@testable import JustWind

extension WeatherResponse {
    
    static var arrange: WeatherResponse {
        let json: [String: Any] = JSONLoader.load("weather_response")
        let data = try! JSONSerialization.data(withJSONObject: json, options: .init(rawValue: 0))
        return try! JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
