import XCTest

@testable import WLNetworkLayer

class NetworkServiceClientTests: XCTestCase {
    
    private var subject: NetworkServiceClient!
    private var mockHttpRequest: MockHttpsRequest!
    
    override func setUp() {
        super.setUp()
        mockHttpRequest = MockHttpsRequest()
        subject = NetworkServiceClient(request: mockHttpRequest)
    }
    
    override func tearDown() {
        subject = nil
        mockHttpRequest = nil
        super.tearDown()
    }
    
    func test_call_success_returnsSuccess() {
        let op = TestVoidOp()
        mockHttpRequest.stubbedError = nil
        mockHttpRequest.stubbedResponse = [
            "cod": "200"
        ]
        let expectation = self.expectation(description: "call")
        subject.call(operation: op) { response in
            switch response {
            case .success:
                XCTPass()
            case .failure:
                XCTFail("Expected success response got: \(response)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func test_call_successWithValue_returnsSuccessWithObject() {
        let op = TestValueOp()
        mockHttpRequest.stubbedResponse = [
            "cod": "200",
            "value1": "test_value"
        ]
        let expectation = self.expectation(description: "call")
        subject.call(operation: op) { response in
            switch response {
            case .success(let response):
                XCTAssertEqual(response.object.value1, "test_value")
            case .failure:
                XCTFail("Expected success response got: \(response)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func test_call_parseError_returnsFailureParse() {
        let op = TestValueOp()
        mockHttpRequest.stubbedResponse = [
            "cod": "200",
            "incorrectKey": "test_value"
        ]
        let expectation = self.expectation(description: "call")
        subject.call(operation: op) { response in
            switch response {
            case .failure(.parse(let error)):
                XCTAssertEqual(error.localizedDescription, "The data couldn’t be read because it is missing.")
            default:
                XCTFail("Expected parse failure response got: \(response)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func test_call_operationError_returnsFailureOperation() {
        let op = TestValueOp()
        mockHttpRequest.stubbedResponse = [
            "cod": "400",
        ]
        let expectation = self.expectation(description: "call")
        subject.call(operation: op) { response in
            switch response {
            case .failure(.operation(let response)):
                XCTAssertTrue(response.failure)
            default:
                XCTFail("Expected parse failure response got: \(response)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
    func test_call_containerError_returnsFailureClient() {
        let op = TestValueOp()
        let stubbedError = TestError()
        mockHttpRequest.stubbedError = stubbedError
        let expectation = self.expectation(description: "call")
        subject.call(operation: op) { response in
            switch response {
            case .failure(.client(let error)):
                let testError = error as! TestError
                XCTAssertEqual(stubbedError.localizedDescription, testError.localizedDescription)
            default:
                XCTFail("Expected client failure response got: \(response)")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
    
}

fileprivate struct TestVoidOp: NetworkOperationProtocol {
    
    typealias ReturnType = Void
    
    var url: String = ""
    
    var parameters: [String: Any]? {
        return nil
    }
}

fileprivate struct TestValueOp: NetworkOperationProtocol {
    
    var url: String = ""
    
    var parameters: [String: Any]? {
        return nil
    }
    
    fileprivate func parse(_ data: Data) throws -> TestResponseObject {
        return try JSONDecoder().decode(TestResponseObject.self, from: data)
    }
}

fileprivate struct TestResponseObject: Codable {
    let value1: String
}

struct TestError: Error {
    var localizedDescription: String = "test_error"
}
