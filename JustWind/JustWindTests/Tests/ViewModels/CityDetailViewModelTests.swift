import XCTest

@testable import WLNetworkLayer
@testable import JustWind

class CityDetailViewModelTests: XCTestCase {

    private var subject: CityDetailViewModel!
    private var mockUserDefault: MockUserDefaults!
    
    private var mockCity: City {
        return City(id: 123,
                    coord: GeoCoordinator(lon: 0, lat: 0),
                    sys: Sys(country: "UK"),
                    name: "London")
    }
    
    override func setUp() {
        super.setUp()
        
        mockUserDefault = MockUserDefaults()
        subject = CityDetailViewModel(service: MockWeatherService(),
                                      city: mockCity,
                                      userDefaults: mockUserDefault)
    }

    override func tearDown() {
        subject = nil
        mockUserDefault = nil
        super.tearDown()
    }

    func test_addToFavourite_addCityId_returnUserDefaultsIncludetheId() {
        subject.addToFavourite()
        XCTAssertTrue(mockUserDefault.isDuplicateId(123))
    }
    
    func test_removeFavourite_removeCityId_returnUserDefaultsUnincludetheId() {
        subject.addToFavourite()
        subject.removeFavourite()
        XCTAssertFalse(mockUserDefault.isDuplicateId(123))
    }
    
    func test_isSavedCity_withCityId_returnTrue() {
        subject.addToFavourite()
        XCTAssertTrue(subject.isSavedCity)
    }
    
    func test_isSavedCity_withoutCityId_returnFalse() {
        subject.removeFavourite()
        XCTAssertFalse(subject.isSavedCity)
    }
}
