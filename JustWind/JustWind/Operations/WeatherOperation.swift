import Foundation
import WLNetworkLayer

final class WeatherOperation<T>: NetworkOperationProtocol where T: Decodable {
    
    var url: String {
        return urlName
    }
    
    var parameters: [String: Any]? {
        return [
            "id": cityId,
            "units": units
        ]
    }
    
    private let urlName: String
    private let cityId: String
    private let units: String
    
    init(urlName: String,
         cityId: String,
         units: String) {
        self.urlName = urlName
        self.cityId = cityId
        self.units = units
    }
    
    func parse(_ data: Data) throws -> T {
        return try JSONDecoder().decode(T.self,
                                        from: data)
    }
}
