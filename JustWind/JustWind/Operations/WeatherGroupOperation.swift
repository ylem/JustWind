import Foundation
import WLNetworkLayer

final class WeatherGroupOperation: NetworkOperationProtocol {
    
    var url: String {
        return "group"
    }
    
    var parameters: [String: Any]? {
        return [
            "id": cityIds,
            "units": units
        ]
    }
    
    private let cityIds: String
    private let units: String
    
    init(cityIds: String,
         units: String) {
        self.cityIds = cityIds
        self.units = units
    }
    
    func parse(_ data: Data) throws -> WeatherGroupResponse {
        return try JSONDecoder().decode(WeatherGroupResponse.self,
                                        from: data)
    }
}
