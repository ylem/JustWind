import UIKit
import WLNetworkLayer

class CityDetailViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let viewModel: CityDetailViewModel
    private var dataSource: CollectionViewDataSource?
    
    private lazy var initialLayout: () -> Void = {
        loadForecast()
        return {}
    }()
    
    init(viewModel: CityDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionLayout()
        configureCollectionCells()
        configureNavigationBar()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initialLayout()
    }
    
    private func configureCollectionLayout() {
        collectionView.collectionViewLayout = StickyHeaderCollectionViewLayout()
    }
    
    private func configureCollectionCells() {
        collectionView.registerNib(SpacerCollectionViewCell.self)
        collectionView.registerNib(ClearTextCollectionViewCell.self)
        collectionView.registerNib(WeatherInfoCollectionViewCell.self)
    }
    
    private func configureNavigationBar() {
        title = viewModel.cityName
        updateNavigationRightButton()
    }
    
    private func updateNavigationRightButton() {
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private var rightBarButton: UIBarButtonItem {
        return viewModel.isSavedCity ? removeFavouriteButton : favouriteButton
    }
    
    private var favouriteButton: UIBarButtonItem {
        return .init(title: "Add Favourite",
                     style: .plain,
                     target: self,
                     action: #selector(addToFavourite))
    }
    
    private var removeFavouriteButton: UIBarButtonItem {
        return .init(title: "Remove Favourite",
                     style: .plain,
                     target: self,
                     action: #selector(removeFavourite))
    }
    
    @objc private func addToFavourite() {
        viewModel.addToFavourite()
        updateNavigationRightButton()
    }
    
    @objc private func removeFavourite() {
        viewModel.removeFavourite()
        updateNavigationRightButton()
    }
    
    private func loadForecast() {
        showLoading()
        viewModel.loadForecast { [weak self] response in
            self?.handleForecastResponse(response)
        }
    }
    
    private func handleForecastResponse(_ response: ServiceClientResponse<ForecastResponse>) {
        hideLoading()
        handle(response, success: { [weak self] response in
            self?.viewModel.set(forecast: response.list)
            self?.loadDataSource()
        })
    }
    
    private var builder: CityDetailDataSourceBuilder? {
        return .init(frame: collectionView.bounds,
                     data: viewModel.displayableData)
    }

    private func loadDataSource() {
        dataSource = CollectionViewDataSourceFlowLayout(collectionView: collectionView,
                                                        sections: builder?.build ?? [])
    }
    
    
}
