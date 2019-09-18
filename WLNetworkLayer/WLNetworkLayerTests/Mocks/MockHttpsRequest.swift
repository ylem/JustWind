import Foundation

@testable import WLNetworkLayer

class MockHttpsRequest: HttpsRequest {
    
    var stubbedResponse: [AnyHashable: Any]?
    var stubbedError: Error?
    
    convenience init() {
        self.init(baseURL: "", session: URLSession())
    }
    
    override func get(url: String,
                      parameters: [String : Any]?,
                      completion: @escaping (Any?, Error?) -> Void) {
        completion(stubbedResponse, stubbedError)
    }
}
