import Foundation
import WLNetworkLayer

class WeatherServices {
    
    private let serviceClient: NetworkServiceClientProtocol
    
    init(serviceClient: NetworkServiceClientProtocol = NetworkServiceClient()) {
        self.serviceClient = serviceClient
    }
    
    func weather(cityId: String,
                 units: String,
                 completion: @escaping ServiceClientCompletion<WeatherResponse>) {
        let operation = WeatherOperation<WeatherResponse>(urlName: "weather", cityId: cityId, units: units)
        serviceClient.call(operation: operation, completion: completion)
    }
    
    func forecast(cityId: String,
                  units: String,
                  completion: @escaping ServiceClientCompletion<ForecastResponse>) {
        let operation = WeatherOperation<ForecastResponse>(urlName: "forecast", cityId: cityId, units: units)
        serviceClient.call(operation: operation, completion: completion)
    }
    
    func group(cityIds: String,
               units: String,
               completion: @escaping ServiceClientCompletion<WeatherGroupResponse>) {
        let operation = WeatherGroupOperation(cityIds: cityIds, units: units)
        serviceClient.call(operation: operation, completion: completion)
    }
}
