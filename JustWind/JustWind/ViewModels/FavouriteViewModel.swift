import Foundation
import WLNetworkLayer

final class FavouriteViewModel {
    
    private let service: WeatherServices
    private(set) var weathers: WeatherGroupResponse?
    
    init(service: WeatherServices) {
        self.service = service
    }
    
    private var savedCities: [Int]? {
        return UserDefaults.standard.savedCityIds
    }
    
    var hasSavedCities: Bool {
        return savedCities != nil
    }
    
    func loadWeathers(units: String = "metric",
                      completion: @escaping ServiceClientCompletion<WeatherGroupResponse>) {
        guard let savedCities: [Int] = savedCities else { return }
        let cityIds: String = savedCities.map { String($0) }.joined(separator: ",")
        service.group(cityIds: cityIds, units: units, completion: completion)
    }
    
    func set(weathers: WeatherGroupResponse?) {
        self.weathers = weathers
    }
    
    var displayableData: [DisplayableWeatherCardData]? {
        guard let weathers = weathers?.list else { return nil }
        
        return weathers.map {
            return .init(city: $0.name,
                         country: $0.sys.country,
                         windSpeed: "\($0.wind.speed)",
                         windDegree: $0.wind.deg ?? 0)
        }
    }
}
