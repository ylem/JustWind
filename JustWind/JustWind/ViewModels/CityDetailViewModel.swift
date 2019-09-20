import Foundation
import WLNetworkLayer

class CityDetailViewModel {
    
    private let service: WeatherServices
    private let city: City
    private let userDefaults: UserDefaults
    private var forecast: [ForecastWeatherResponse]?
    
    init(service: WeatherServices,
         city: City,
         userDefaults: UserDefaults = UserDefaults.standard) {
        self.service = service
        self.city = city
        self.userDefaults = userDefaults
    }
    
    var cityName: String {
        return city.name
    }
    
    func loadForecast(completion: @escaping ServiceClientCompletion<ForecastResponse>) {
        service.forecast(cityId: "\(city.id)",
                         units: "metric",
                         completion: completion)
    }
    
    func set(forecast: [ForecastWeatherResponse]?) {
        self.forecast = forecast
    }
    
    var displayableData: CityDetailDisplayable? {
        return .init(city: city,
                     forecast: forecast)
        
    }
    
    var isSavedCity: Bool {
        return userDefaults.isDuplicateId(city.id)
    }
    
    func addToFavourite() {
        userDefaults.save(cityId: city.id)
    }
    
    func removeFavourite() {
        userDefaults.delete(cityId: city.id)
    }
}
