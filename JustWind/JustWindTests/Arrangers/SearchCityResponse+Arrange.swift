import Foundation

@testable import JustWind

extension SearchCityResponse {
    
    static var arrange: SearchCityResponse {
        let json: [String: Any] = JSONLoader.load("search_city_response")
        let data = try! JSONSerialization.data(withJSONObject: json, options: .init(rawValue: 0))
        return try! JSONDecoder().decode(SearchCityResponse.self, from: data)
    }
    
    static var emptyArrange: SearchCityResponse {
        let json: [String: Any] = JSONLoader.load("search_city_empty_response")
        let data = try! JSONSerialization.data(withJSONObject: json, options: .init(rawValue: 0))
        return try! JSONDecoder().decode(SearchCityResponse.self, from: data)
    }
    
}
