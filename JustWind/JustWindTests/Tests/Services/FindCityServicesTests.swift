import XCTest

@testable import JustWind

class FindCityServicesTests: XCTestCase {
    
    private var subject: FindCityServices!
    private var mockClient: MockNetworkServiceClient!
    
    override func setUp() {
        super.setUp()
        mockClient = MockNetworkServiceClient()
        subject = FindCityServices(serviceClient: mockClient)
    }
    
    override func tearDown() {
        mockClient = nil
        subject = nil
        super.tearDown()
    }
    
    func test_search_withSuccess_returnsSuccessResponse() {
        let object: SearchCityResponse = .arrange
        mockClient.stub(with: .arrangeSuccess(object))
        let subjectExpectation = expectation(description: "search_city")
        subject.search(keyword: "manchester", completion: {
            response in
            switch response {
            case .success(let success):
                XCTAssertEqual(success.object.count, 5)
                XCTAssertEqual(success.object.list.first?.id, 5089178)
            default:
                XCTFail("Expected success")
            }
            subjectExpectation.fulfill()
        })
        waitForExpectations(timeout: 0.1)
    }
    
    func test_search_withSuccess_returnsEmptyResponse() {
        let object: SearchCityResponse = .emptyArrange
        mockClient.stub(with: .arrangeSuccess(object))
        let subjectExpectation = expectation(description: "search_city")
        subject.search(keyword: "xxx", completion: {
            response in
            switch response {
            case .success(let success):
                XCTAssertEqual(success.object.count, 0)
                XCTAssertEqual(success.object.list.count, 0)
            default:
                XCTFail("Expected success")
            }
            subjectExpectation.fulfill()
        })
        waitForExpectations(timeout: 0.1)
    }
}
