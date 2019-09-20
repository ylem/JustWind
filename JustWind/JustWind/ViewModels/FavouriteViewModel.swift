import Foundation
import WLNetworkLayer

final class FavouriteViewModel {
    
    private let service: WeatherServices
    
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
}
