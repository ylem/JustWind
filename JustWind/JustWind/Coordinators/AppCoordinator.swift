import UIKit

class AppCoordinator: Coordinator {
    
    var presenter: UINavigationController
    
    private let window: UIWindow?
    private let coordinatorBuilder: CoordinatorBuilder
    private let viewControllerBuilder: ViewControllerBuilder
    private var favouriteCoordinator: FavouriteCoordinator?
    
    init(presenter: UINavigationController,
         window: UIWindow?,
         coordinatorBuilder: CoordinatorBuilder,
         viewControllerBuilder: ViewControllerBuilder) {
        self.presenter = presenter
        self.window = window
        self.coordinatorBuilder = coordinatorBuilder
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func start() {
        showFavouriteViewController()
    }
    
    private func showFavouriteViewController() {
        let coor = coordinatorBuilder.favourite(presenter: presenter)
        coor.start()
        favouriteCoordinator = coor
    }
}
