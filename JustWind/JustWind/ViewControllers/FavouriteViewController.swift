import UIKit
import WLNetworkLayer

class FavouriteViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let viewModel: FavouriteViewModel
    private var dataSource: CollectionViewDataSource?
    
    init(viewModel: FavouriteViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Just Wind"
        configureCollectionLayout()
        configureCollectionCells()
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
        collectionView.registerNib(ImageCollectionCell.self)
        collectionView.registerNib(FavouriteCityCollectionViewCell.self)
    }
    
    private lazy var initialLayout: () -> Void = { [weak self] in
        self?.loadWeatherGroup()
        return {}
    }()
    
    private func loadWeatherGroup() {
        guard viewModel.hasSavedCities else {
            return loadDataSource()
        }
        
        showLoading()
        viewModel.loadWeathers { [weak self] response in
            self?.handleWeatherGroupResponse(response)
        }
    }
    
    private func handleWeatherGroupResponse(_ response: ServiceClientResponse<WeatherGroupResponse>) {
        hideLoading()
        handle(response,
               success:  { [weak self] object in
            self?.viewModel.set(weathers: object)
            self?.loadDataSource()
        })
    }
    
    private var builder: FavouriteDataSourceBuilder {
        return .init(frame: collectionView.bounds,
                     data: viewModel.displayableData)
    }
    
    private func loadDataSource() {
        dataSource = CollectionViewDataSourceFlowLayout(collectionView: collectionView,
                                                        sections: builder.build)
    }
}
