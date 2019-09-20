import UIKit
import WLNetworkLayer

protocol FavouriteViewControllerDelegate: class {
    func addCity()
    func showDetail(city: City)
}

class FavouriteViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var plusButton: UIButton!
    
    private let viewModel: FavouriteViewModel
    private var dataSource: CollectionViewDataSource?
    private weak var delegate: FavouriteViewControllerDelegate?
    
    init(viewModel: FavouriteViewModel,
         delegate: FavouriteViewControllerDelegate?) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private lazy var initialLayout: () -> Void = {
        configurePlusButton()
        return {}
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Just Wind"
        configureCollectionLayout()
        configureCollectionCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadWeatherGroup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        initialLayout()
    }
    
    private func configurePlusButton() {
        let cornerRadius: CGFloat = plusButton.bounds.width / 2
        let image = UIImage(imageLiteralResourceName: "plus").withRenderingMode(.alwaysTemplate)
        plusButton.setImage(image, for: .normal)
        plusButton.imageView?.tintColor = .white
        plusButton.backgroundColor = .orange
        plusButton.layer.cornerRadius = cornerRadius
        plusButton.layer.applyShadow(blur: cornerRadius, bounds: plusButton.bounds)
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
    
    private func loadWeatherGroup() {
        viewModel.clear()
        
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
    
    private lazy var builder: FavouriteDataSourceBuilder = {
        return .init(frame: collectionView.bounds,
                     data: viewModel.displayableData,
                     didSelectCity: selectedCity)
    }()
    
    private func selectedCity(_ id: Int) {
        guard let city = viewModel.selectedCity(id: id) else { return }
        delegate?.showDetail(city: city)
    }
    
    private func loadDataSource() {
        dataSource = CollectionViewDataSourceFlowLayout(collectionView: collectionView,
                                                        sections: builder.build)
    }
    
    @IBAction private func plusButtonPressed(_ sender: Any) {
        delegate?.addCity()
    }
}
