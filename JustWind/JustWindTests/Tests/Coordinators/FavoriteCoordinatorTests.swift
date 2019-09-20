import XCTest

@testable import JustWind

class FavoriteCoordinatorTests: XCTestCase {

    private var subject: FavouriteCoordinator!
    private var mockNav: UINavigationController!
    private var mockCoorBuilder: MockCoordinatorBuilder!
    private var mockVCBuilder: MockViewControllerBuilder!
    
    override func setUp() {
        super.setUp()
        
        mockNav = UINavigationController()
        mockCoorBuilder = MockCoordinatorBuilder()
        mockVCBuilder = MockViewControllerBuilder()
        subject = FavouriteCoordinator(presenter: mockNav,
                                       coordinatorBuilder: mockCoorBuilder,
                                       viewControllerBuilder: mockVCBuilder)
    }

    override func tearDown() {
        subject = nil
        mockNav = nil
        mockCoorBuilder = nil
        mockVCBuilder = nil
        super.tearDown()
    }

    func test_start_called_showFavouriteVC() {
        let mockVC = UIViewController()
        mockVCBuilder._stubbedFavouriteViewController = mockVC
        subject.start()
        XCTAssertTrue(mockNav.viewControllers.first == mockVC)
    }
    
    func test_addCity_called_startSearchCityCoordinator() {
        let mockCoor = MockSearchCityCoordinator(presenter: mockNav,
                                                 coordinatorBuilder: mockCoorBuilder,
                                                 viewControllerBuilder: mockVCBuilder)
        mockCoorBuilder._stubbedSearchCoordinator = mockCoor
        subject.addCity()
        XCTAssertTrue(mockCoor._startCalled)
    }

    func test_showDetail_called_startCityDetailCoordinator() {
        let mockCity = City(id: 0, coord: GeoCoordinator(lon: 0, lat: 0), sys: Sys(country: "uk"), name: "name")
        let mockCoor = MockCityDetailCoordinator(presenter: mockNav,
                                                 selectedCity: mockCity,
                                                 coordinatorBuilder: mockCoorBuilder,
                                                 viewControllerBuilder: mockVCBuilder)
        mockCoorBuilder._stubbedCityDetailCoordinator = mockCoor
        subject.showDetail(city: mockCity)
        XCTAssertTrue(mockCoor._startCalled)
    }
}


class MockSearchCityCoordinator: SearchCityCoordinator {
    
    var _startCalled: Bool = false
    override func start() {
        _startCalled = true
    }
}

class MockCityDetailCoordinator: CityDetailCoordinator {
    
    var _startCalled: Bool = false
    override func start() {
        _startCalled = true
    }
}
