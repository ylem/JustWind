import Foundation
import WLNetworkLayer

final class FindCityServices {
    
    private let serviceClient: NetworkServiceClientProtocol
    
    init(serviceClient: NetworkServiceClientProtocol = NetworkServiceClient()) {
        self.serviceClient = serviceClient
    }
    
    func search(keyword: String,
                completion: @escaping ServiceClientCompletion<SearchCityResponse>) {
        let operation = SearchCityOperation(keyword: keyword)
        serviceClient.call(operation: operation, completion: completion)
    }
}
