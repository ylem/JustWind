import Foundation
import WLNetworkLayer

final class WeatherOperation<T>: NetworkOperationProtocol where T: Decodable {
    
    var url: String {
        return "weather"
    }
    
    var parameters: [String: Any]? {
        return [
            "id": cityId,
            "units": units
        ]
    }
    
    private let cityId: String
    private let units: String
    
    init(cityId: String,
         units: String) {
        self.cityId = cityId
        self.units = units
    }
    
    func parse(_ data: Data) throws -> T {
        return try JSONDecoder().decode(T.self,
                                        from: data)
    }
}
