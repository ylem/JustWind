import Foundation
import WLNetworkLayer

final class WeatherServices {
    
    private let serviceClient: NetworkServiceClientProtocol
    
    init(serviceClient: NetworkServiceClientProtocol = NetworkServiceClient()) {
        self.serviceClient = serviceClient
    }
    
    func weather(cityId: UInt64,
                 units: String = "metric",
                 completion: @escaping ServiceClientCompletion<WeatherResponse>) {
        let operation = WeatherOperation<WeatherResponse>(cityId: cityId, units: units)
        serviceClient.call(operation: operation, completion: completion)
    }
    
    func forecast(cityId: UInt64,
                  units: String = "metric",
                  completion: @escaping ServiceClientCompletion<ForecastResponse>) {
        let operation = WeatherOperation<ForecastResponse>(cityId: cityId, units: units)
        serviceClient.call(operation: operation, completion: completion)
    }
}
