import UIKit

class AppCoordinator: Coordinator {
    
    var presenter: UINavigationController
    
    private let window: UIWindow?
    private let viewControllerBuilder: ViewControllerBuilder
    
    init(presenter: UINavigationController,
         window: UIWindow?,
         viewControllerBuilder: ViewControllerBuilder) {
        self.presenter = presenter
        self.window = window
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func start() {
        showFavouriteViewController()
    }
    
    private func showFavouriteViewController() {
        let vc = viewControllerBuilder.favourite()
        presenter.setViewControllers([vc], animated: false)
    }
}
