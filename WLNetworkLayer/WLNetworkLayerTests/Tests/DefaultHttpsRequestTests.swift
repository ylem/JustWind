import XCTest

@testable import WLNetworkLayer

class DefaultHttpsRequestTests: XCTestCase {
    
    private var subject: DefaultHttpsRequest!
    
    override func setUp() {
        super.setUp()
        subject = DefaultHttpsRequest(baseURL: "https://apiurl/",
                                      session: URLSession())
    }
    
    override func tearDown() {
        subject = nil
        super.tearDown()
    }
    
    func test_weatherAppURLString_withParameters_returnExpectedValue() {
        let target = subject.weatherAppURL(urlString: "weather",
                                           parameters: ["id":1234, "units": "metric"])
        // dictionary not sorted by keys, so the final url string can be one of following.
        let expected1 = "https://apiurl/weather?appid=d797525adfb367562531a1ec8f687706&id=1234&units=metric"
        let expected2 = "https://apiurl/weather?appid=d797525adfb367562531a1ec8f687706&units=metric&id=1234"
        
        XCTAssertTrue((target?.relativeString == expected1 || target?.relativeString == expected2))
    }
}
