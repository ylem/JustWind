import UIKit

class CityDetailCoordinator: Coordinator {
    
    var presenter: UINavigationController
    
    private let selectedCity: City
    private let viewControllerBuilder: ViewControllerBuilder
    private let coordinatorBuilder: CoordinatorBuilder
    
    init(presenter: UINavigationController,
         selectedCity: City,
         coordinatorBuilder: CoordinatorBuilder,
         viewControllerBuilder: ViewControllerBuilder) {
        self.presenter = presenter
        self.selectedCity = selectedCity
        self.coordinatorBuilder = coordinatorBuilder
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    func start() {
        showDetailViewController()
    }
    
    private func showDetailViewController() {
        let vc = viewControllerBuilder.detail(city: selectedCity)
        presenter.pushViewController(vc, animated: true)
    }
}
