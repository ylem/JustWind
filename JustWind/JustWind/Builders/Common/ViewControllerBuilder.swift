import UIKit

final class ViewControllerBuilder {
    
    func favourite() -> UIViewController {
        let viewModel = FavouriteViewModel(service: WeatherServices())
        return FavouriteViewController(viewModel: viewModel)
    }
}
