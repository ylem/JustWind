import XCTest

@testable import WLNetworkLayer

class ServiceClientErrorTests: XCTestCase {
    
    private var subject: ServiceClientError!
    
    override func tearDown() {
        super.tearDown()
        self.subject = nil
    }
    
    func test_title_parse_isEqualToExpectedValue() {
        let error = NSError(domain: "", code: 100, userInfo: nil)
        subject = .parse(error)
        XCTAssertEqual(subject.title, "Error")
    }
    
    func test_message_parse_isEqualToExpectedValue() {
        let error = NSError(domain: "Parse", code: 100, userInfo: nil)
        subject = .parse(error)
        XCTAssertEqual(subject.message, error.localizedDescription)
    }
    
    func test_title_operation_isEqualToExpectedValue() {
        let operationResponse = OperationResponse(status: "200")
        subject = .operation(operationResponse)
        XCTAssertEqual(subject.title, "200")
    }
    
    func test_message_operation_isEqualToExpectedValue() {
        let operationResponse = OperationResponse(status: "404")
        subject = .operation(operationResponse)
        XCTAssertEqual(subject.message, "404")
    }
}
