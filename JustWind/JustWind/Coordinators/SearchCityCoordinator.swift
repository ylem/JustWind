import UIKit

class SearchCityCoordinator: Coordinator {
    
    var presenter: UINavigationController
    private let viewControllerBuilder: ViewControllerBuilder
    private let completion: () -> Void
    
    init(presenter: UINavigationController,
         viewControllerBuilder: ViewControllerBuilder,
         completion: @escaping () -> Void) {
        self.presenter = presenter
        self.viewControllerBuilder = viewControllerBuilder
        self.completion = completion
    }
    
    func start() {
        showSearchCityViewController()
    }
    
    private func showSearchCityViewController() {
        let vc = viewControllerBuilder.searchCity(delegate: self)
        presenter.present(vc, animated: true, completion: nil)
    }
    
    deinit {
        debugPrint("deinit - SearchCityCoordinator")
    }
}

extension SearchCityCoordinator: SearchCityViewControllerDelegate {
    
    func didSelectCity(_ city: City) {
        print(city.name)
    }
}
