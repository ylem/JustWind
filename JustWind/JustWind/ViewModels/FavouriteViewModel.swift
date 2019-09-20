import Foundation
import WLNetworkLayer

final class FavouriteViewModel {
    
    private let service: WeatherServices
    private let userDefault: UserDefaults
    private(set) var weathers: WeatherGroupResponse?
    private var cities: [City]?
    
    init(service: WeatherServices,
         userDefault: UserDefaults = .standard) {
        self.service = service
        self.userDefault = userDefault
    }
    
    private var savedCities: [Int]? {
        return userDefault.savedCityIds
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
        
        cities = weathers?.list.compactMap {
            guard let id = $0.id else { return nil }
            return City(id: id, coord: $0.coord, sys: $0.sys, name: $0.name)
        }
    }
    
    func selectedCity(id: Int) -> City? {
        return cities?.first(where: { $0.id == id })
    }
    
    func displayableData() -> [DisplayableWeatherCardData]? {
        guard let weathers = weathers?.list else { return nil }
        
        return weathers.compactMap {
            guard let id = $0.id else { return nil }
            return .init(cityId: id,
                         city: $0.name,
                         country: $0.sys.country,
                         windSpeed: "\($0.wind.speed)",
                         windDegree: $0.wind.deg ?? 0)
        }
    }
}
