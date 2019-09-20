import UIKit
import WLNetworkLayer

protocol SearchCityViewControllerDelegate: class {

    func didSelectCity(_ city: City)
}

class SearchCityViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let viewModel: SearchCityViewModel
    private var dataSource: CollectionViewDataSource?
    private weak var delegate: SearchCityViewControllerDelegate?
    
    init(viewModel: SearchCityViewModel,
         delegate: SearchCityViewControllerDelegate?) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureCollectionLayout()
        configureCollectionCells()
    }
    
    private lazy var initialLayout: () -> Void = {
        loadDataSource()
        return {}
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initialLayout()
    }
    
    private func configureNavigationBar() {
        title = "Search"
        navigationItem.leftBarButtonItem = closeButton
        navigationItem.leftBarButtonItem?.tintColor = .g1
    }
    
    private var closeButton: UIBarButtonItem {
        return .init(image: UIImage(imageLiteralResourceName: "cross"),
                     style: .plain,
                     target: self,
                     action: #selector(close))
    }
    
    private func configureCollectionLayout() {
        collectionView.collectionViewLayout = StickyHeaderCollectionViewLayout()
    }
    
    private func configureCollectionCells() {
        collectionView.registerNib(SpacerCollectionViewCell.self)
        collectionView.registerNib(ClearTextCollectionViewCell.self)
        collectionView.registerNib(SearchTextFieldCollectionViewCell.self)
        collectionView.registerNib(CitySearchResultCollectionViewCell.self)
        collectionView.registerNib(ImageCollectionCell.self)
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    private lazy var builder: SearchCityDataSourceBuilder = {
        return SearchCityDataSourceBuilder(frame: collectionView.bounds,
                                           data: data,
                                           didEndEditing: didEndEditing,
                                           didSelectCity: didSelectCity)
    }()
    
    private func loadDataSource() {
        dataSource = CollectionViewDataSourceFlowLayout(collectionView: collectionView,
                                                        sections: builder.build)
    }
    
    private func didEndEditing(text: String?) {
        guard let text = text else { return }
        showLoading()
        viewModel.search(city: text) { [weak self] response in
            self?.handleSearchResponse(response)
        }
    }
    
    private func handleSearchResponse(_ response: ServiceClientResponse<SearchCityResponse>) {
        hideLoading()
        handle(response, success: { [weak self] response in
            self?.viewModel.set(searchCityResponse: response)
            self?.loadDataSource()
        })
    }
    
    private func data() -> [City]? {
        return viewModel.cities
    }
    
    private func didSelectCity(_ city: City) {
        delegate?.didSelectCity(city)
    }
}
