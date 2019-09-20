import Foundation

@testable import JustWind
@testable import WLNetworkLayer

class MockWeatherService: WeatherServices {
    
    var _stubbedWeatherResponse: ServiceClientResponse<WeatherResponse>?
    var _stubbedWeatherResponseOperation: ServiceClientCompletion<WeatherResponse>?
    override func weather(cityId: String,
                          units: String,
                          completion: @escaping ServiceClientCompletion<WeatherResponse>) {
        _stubbedWeatherResponseOperation = completion
        let response: ServiceClientResponse<WeatherResponse> = _stubbedWeatherResponse ?? .arrangeSuccess(.arrange)
        completion(response)
    }
    
    var _stubbedForecastResponse: ServiceClientResponse<ForecastResponse>?
    var _stubbedForecastResponseOperation: ServiceClientCompletion<ForecastResponse>?
    override func forecast(cityId: String, units: String, completion: @escaping ServiceClientCompletion<ForecastResponse>) {
        _stubbedForecastResponseOperation = completion
        let response: ServiceClientResponse<ForecastResponse> = _stubbedForecastResponse ?? .arrangeSuccess(.arrange)
        completion(response)
    }
    
    var _stubbedGroupResponse: ServiceClientResponse<WeatherGroupResponse>?
    var _stubbedGroupResponseOperation: ServiceClientCompletion<WeatherGroupResponse>?
    override func group(cityIds: String, units: String, completion: @escaping ServiceClientCompletion<WeatherGroupResponse>) {
        _stubbedGroupResponseOperation = completion
        let response: ServiceClientResponse<WeatherGroupResponse> = _stubbedGroupResponse ?? .arrangeSuccess(.arrange)
        return completion(response)
    }
    
}
