import Foundation
import WLNetworkLayer

final class WeatherOperation<T>: NetworkOperationProtocol where T: Decodable {
    
    var url: String {
        return "weather"
    }
    
    var parameters: [String: Any]? {
        return [
            "id": "\(cityId)",
            "units": units
        ]
    }
    
    private let cityId: UInt64
    private let units: String
    
    init(cityId: UInt64,
         units: String) {
        self.cityId = cityId
        self.units = units
    }
    
    func parse(_ data: Data) throws -> T {
        return try JSONDecoder().decode(T.self,
                                        from: data)
    }
}
