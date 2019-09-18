import Foundation

@testable import WLNetworkLayer
@testable import JustWind

class MockNetworkServiceClient: NetworkServiceClientProtocol {
    
    private var _stubbedCallResponses: Any?
    func stub<T>(with response: ServiceClientResponse<T>) {
        _stubbedCallResponses = response
    }
    
    var _sutbbedResponse: ServiceClientResponse<Any>?
    func call<O: NetworkOperationProtocol>(operation: O,
                                           completion: @escaping (ServiceClientResponse<O.ReturnType>) -> Void) {
        let response = _stubbedCallResponses as! ServiceClientResponse<O.ReturnType>
        completion(response)
    }
}
