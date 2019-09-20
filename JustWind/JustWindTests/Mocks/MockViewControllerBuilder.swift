import UIKit

@testable import JustWind

class MockViewControllerBuilder: ViewControllerBuilder {
    
    var _stubbedFavouriteViewController: UIViewController?
    override func favourite(delegate: FavouriteViewControllerDelegate?) -> UIViewController {
        return _stubbedFavouriteViewController!
    }
    
    var _stubbedSearchCityViewController: UIViewController?
    override func searchCity(delegate: SearchCityViewControllerDelegate?) -> UIViewController {
        return _stubbedSearchCityViewController!
    }
    
    var _stubbedCityDetailViewController: UIViewController?
    override func detail(city: City) -> UIViewController {
        return _stubbedCityDetailViewController!
    }
}
