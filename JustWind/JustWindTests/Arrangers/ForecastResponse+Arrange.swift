import Foundation

@testable import JustWind

extension ForecastResponse {
    
    static var arrange: ForecastResponse {
        let json: [String: Any] = JSONLoader.load("forecast_response")
        let data = try! JSONSerialization.data(withJSONObject: json, options: .init(rawValue: 0))
        return try! JSONDecoder().decode(ForecastResponse.self, from: data)
    }
    
}
