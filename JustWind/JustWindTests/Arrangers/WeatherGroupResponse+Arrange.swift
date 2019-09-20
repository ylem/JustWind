import Foundation

@testable import JustWind

extension WeatherGroupResponse {
    
    static var arrange: WeatherGroupResponse {
        let json: [String: Any] = JSONLoader.load("weathergroup_response")
        let data = try! JSONSerialization.data(withJSONObject: json, options: .init(rawValue: 0))
        return try! JSONDecoder().decode(WeatherGroupResponse.self, from: data)
    }
}
