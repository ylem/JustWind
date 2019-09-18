import XCTest

@testable import WLNetworkLayer

class OperationResponseTests: XCTestCase {
    
    private var subject: OperationResponse?
    
    func test_decode_withSuccessStatus_setsStatusSuccess() {
        let response = [
            "cod": "200"
        ]
        let data = try! JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
        do {
            self.subject = try JSONDecoder().decode(OperationResponse.self, from: data)
        } catch {
            print(error)
        }
        XCTAssertEqual(subject?.status, "200")
    }
    
}
