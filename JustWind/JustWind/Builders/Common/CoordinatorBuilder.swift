import UIKit

final class CoordinatorBuilder {

    func app(presenter: UINavigationController,
             window: UIWindow?) -> Coordinator {
        return AppCoordinator(presenter: presenter,
                              window: window,
                              viewControllerBuilder: ViewControllerBuilder())
    }
}
