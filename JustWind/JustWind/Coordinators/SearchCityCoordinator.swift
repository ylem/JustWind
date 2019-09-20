import UIKit

class SearchCityCoordinator: Coordinator {
    
    var presenter: UINavigationController
    private let coordinatorBuilder: CoordinatorBuilder
    private let viewControllerBuilder: ViewControllerBuilder
    private var baseNavigationConroller: UINavigationController?
    
    init(presenter: UINavigationController,
         coordinatorBuilder: CoordinatorBuilder,
         viewControllerBuilder: ViewControllerBuilder) {
        self.presenter = presenter
        self.coordinatorBuilder = coordinatorBuilder
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func start() {
        showSearchCityViewController()
    }
    
    private func showSearchCityViewController() {
        let vc = viewControllerBuilder.searchCity(delegate: self)
        let nav = UINavigationController(rootViewController: vc)
        presenter.present(nav, animated: true, completion: nil)
        baseNavigationConroller = nav
    }
    
    private func showCityDetail(_ city: City) {
        guard let nav = baseNavigationConroller else { return }
        let coordinator = coordinatorBuilder.detail(presenter: nav,
                                                    selectedCity: city)
        coordinator.start()
    }
    
    deinit {
        debugPrint("deinit - SearchCityCoordinator")
    }
}

extension SearchCityCoordinator: SearchCityViewControllerDelegate {
    
    func didSelectCity(_ city: City) {
        showCityDetail(city)
    }
}
