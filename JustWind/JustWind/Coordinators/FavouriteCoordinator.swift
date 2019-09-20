import UIKit

class FavouriteCoordinator: Coordinator {
    
    var presenter: UINavigationController
    private let viewControllerBuilder: ViewControllerBuilder
    private let coordinatorBuilder: CoordinatorBuilder
    private var searchCityCoordinator: SearchCityCoordinator?
    
    init(presenter: UINavigationController,
         coordinatorBuilder: CoordinatorBuilder,
         viewControllerBuilder: ViewControllerBuilder) {
        self.presenter = presenter
        self.coordinatorBuilder = coordinatorBuilder
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func start() {
        showFavouriteViewController()
    }
    
    private func showFavouriteViewController() {
        let vc = viewControllerBuilder.favourite(delegate: self)
        presenter.setViewControllers([vc], animated: false)
    }
    
    private func showSearchCity() {
        let coordinator = coordinatorBuilder.search(presenter: presenter)
        coordinator.start()
        searchCityCoordinator = coordinator
    }
    
    private func showCityDetail(city: City) {
        let coordinator = coordinatorBuilder.detail(presenter: presenter,
                                                    selectedCity: city)
        coordinator.start()
    }
    
    deinit {
        debugPrint("deinit - FavouriteCoordinator")
    }
}

extension FavouriteCoordinator: FavouriteViewControllerDelegate {
    
    func addCity() {
        showSearchCity()
    }
    
    func showDetail(city: City) {
        showCityDetail(city: city)
    }
}
