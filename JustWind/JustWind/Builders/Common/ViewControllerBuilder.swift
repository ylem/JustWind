import UIKit

class ViewControllerBuilder {
    
    func favourite(delegate: FavouriteViewControllerDelegate?) -> UIViewController {
        let viewModel = FavouriteViewModel(service: WeatherServices())
        return FavouriteViewController(viewModel: viewModel, delegate: delegate)
    }
    
    func searchCity(delegate: SearchCityViewControllerDelegate?) -> UIViewController {
        let viewModel = SearchCityViewModel(service: FindCityServices())
        return SearchCityViewController(viewModel: viewModel,
                                        delegate: delegate)
    }
    
    func detail(city: City) -> UIViewController {
        let viewModel = CityDetailViewModel(service: WeatherServices(),
                                            city: city)
        return CityDetailViewController(viewModel: viewModel)
    }
}
