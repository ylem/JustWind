import UIKit

class CoordinatorBuilder {

    func app(presenter: UINavigationController,
             window: UIWindow?) -> AppCoordinator {
        return AppCoordinator(presenter: presenter,
                              window: window,
                              coordinatorBuilder: CoordinatorBuilder(),
                              viewControllerBuilder: ViewControllerBuilder())
    }
    
    func favourite(presenter: UINavigationController) -> FavouriteCoordinator {
        return FavouriteCoordinator(presenter: presenter,
                                    coordinatorBuilder: CoordinatorBuilder(),
                                    viewControllerBuilder: ViewControllerBuilder())
    }
    
    func search(presenter: UINavigationController) -> SearchCityCoordinator {
        return SearchCityCoordinator(presenter: presenter,
                                     coordinatorBuilder: CoordinatorBuilder(),
                                     viewControllerBuilder: ViewControllerBuilder())
    }
    
    func detail(presenter: UINavigationController,
                selectedCity: City) -> CityDetailCoordinator {
        return CityDetailCoordinator(presenter: presenter,
                                     selectedCity: selectedCity,
                                     coordinatorBuilder: CoordinatorBuilder(),
                                     viewControllerBuilder: ViewControllerBuilder())
    }
}
