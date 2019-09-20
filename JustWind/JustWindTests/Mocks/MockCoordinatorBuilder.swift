import UIKit

@testable import JustWind

class MockCoordinatorBuilder: CoordinatorBuilder {

    var _stubbedFavouriteCoordinator: FavouriteCoordinator?
    override func favourite(presenter: UINavigationController) -> FavouriteCoordinator {
        return _stubbedFavouriteCoordinator!
    }
    
    var _stubbedSearchCoordinator: SearchCityCoordinator?
    override func search(presenter: UINavigationController) -> SearchCityCoordinator {
        return _stubbedSearchCoordinator!
    }
    
    var _stubbedCityDetailCoordinator: CityDetailCoordinator?
    override func detail(presenter: UINavigationController,
                         selectedCity: City) -> CityDetailCoordinator {
        return _stubbedCityDetailCoordinator!
    }
    
}
