import UIKit

final class CoordinatorBuilder {

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
    
    func search(presenter: UINavigationController,
                completion: @escaping () -> Void) -> SearchCityCoordinator {
        return SearchCityCoordinator(presenter: presenter,
                                     viewControllerBuilder: ViewControllerBuilder(),
                                     completion: completion)
    }
}
