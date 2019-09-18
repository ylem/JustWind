import XCTest

@testable import JustWind

class WeatherServicesTests: XCTestCase {
    
    private var subject: WeatherServices!
    private var mockClient: MockNetworkServiceClient!
    
    override func setUp() {
        super.setUp()
        mockClient = MockNetworkServiceClient()
        subject = WeatherServices(serviceClient: mockClient)
    }
    
    override func tearDown() {
        mockClient = nil
        subject = nil
        super.tearDown()
    }
    
    func test_weather_withSuccess_returnsSuccessResponse() {
        let object: WeatherResponse = .arrange
        mockClient.stub(with: .arrangeSuccess(object))
        let subjectExpectation = expectation(description: "weather")
        subject.weather(cityId: 1234, completion: {
            response in
            switch response {
            case .success(let success):
                XCTAssertEqual(success.object.wind.speed, 0.5)
                XCTAssertEqual(success.object.weather.first?.id, 800)
            default:
                XCTFail("Expected success")
            }
            subjectExpectation.fulfill()
        })
        waitForExpectations(timeout: 0.1)
    }
    
    func test_forecast_withSuccess_returnsSuccessResponse() {
        let object: ForecastResponse = .arrange
        mockClient.stub(with: .arrangeSuccess(object))
        let subjectExpectation = expectation(description: "forecast")
        subject.forecast(cityId: 1234, completion: {
            response in
            switch response {
            case .success(let success):
                XCTAssertEqual(success.object.cnt, 9)
                XCTAssertEqual(success.object.list.first?.wind.speed, 2.47)
            default:
                XCTFail("Expected success")
            }
            subjectExpectation.fulfill()
        })
        waitForExpectations(timeout: 0.1)
    }
}
