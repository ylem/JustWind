import Foundation
import WLNetworkLayer

final class SearchCityViewModel {
    
    private let service: FindCityServices
    private var searchCityResponse: SearchCityResponse?
    
    var cities: [City]? {
        return searchCityResponse?.list
    }
    
    init(service: FindCityServices) {
        self.service = service
    }

    func search(city: String, completion: @escaping ServiceClientCompletion<SearchCityResponse>) {
        service.search(keyword: city, completion: completion)
    }
    
    func set(searchCityResponse: SearchCityResponse) {
        self.searchCityResponse = searchCityResponse
    }
}
