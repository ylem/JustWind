import XCTest

@testable import JustWind

class FavouriteViewModelTests: XCTestCase {

    private var subject: FavouriteViewModel!
    private var mockService: MockWeatherService!
    private var mockUserDefault: MockUserDefaults!
    
    override func setUp() {
        mockService = MockWeatherService()
        mockUserDefault = MockUserDefaults()
        subject = FavouriteViewModel(service: mockService, userDefault: mockUserDefault)
    }
    
    override func tearDown() {
        subject = nil
        mockService = nil
        super.tearDown()
    }
    
    func test_loadWeather_withSuccess_returnSuccessResponse() {
        mockUserDefault.save(cityId: 123)
        let response: WeatherGroupResponse = .arrange
        mockService._stubbedGroupResponse = .arrangeSuccess(response)
        let subjectExpectation = expectation(description: "loadWeather")
        subject.loadWeathers(completion: { response in
            switch response {
            case .success(let success):
                XCTAssertEqual(success.object.cnt, 3)
                XCTAssertEqual(success.object.list.first?.wind.speed, 5)
            default:
                XCTFail("Expected success")
            }
            subjectExpectation.fulfill()
        })
        waitForExpectations(timeout: 0.2)
    }
    
    func test_setWeather_withValues_weathersHasSameValue() {
        subject.set(weathers: .arrange)
        XCTAssertEqual(subject.weathers?.cnt, WeatherGroupResponse.arrange.cnt)
    }
    
    func test_selectedCity_withId_returnExpectedCity() {
        subject.set(weathers: .arrange)
        let target = subject.selectedCity(id: 524901)
        XCTAssertEqual(target?.name, "Moscow")
    }
    
    func test_displayableData_returnValue_isNotNil() {
        subject.set(weathers: .arrange)
        XCTAssertNotNil(subject.displayableData)
    }

    func test_hasSavedCities_withoutSavedCities_returnFalse() {
        mockUserDefault.anyDefaults = ["justwind_saved_city_ids": []]
        XCTAssertFalse(subject.hasSavedCities)
    }
    
    func test_hasSavedCities_withSavedCities_returnTrue() {
        mockUserDefault.anyDefaults = ["justwind_saved_city_ids": [123]]
        XCTAssertTrue(subject.hasSavedCities)
    }
}
