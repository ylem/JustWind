import Foundation

public struct NetworkServiceClient: NetworkServiceClientProtocol {
    
    private let request: HttpsRequest
    private let responseHandler: ServiceClientResponseHandler
    
    public init(request: HttpsRequest = DefaultHttpsRequest(),
                responseHandler: ServiceClientResponseHandler = ServiceClientResponseHandler()) {
        self.request = request
        self.responseHandler = responseHandler
    }
    
    public func call<O>(operation: O,
                        completion: @escaping (ServiceClientResponse<O.ReturnType>) -> Void)
        where O : NetworkOperationProtocol {
            request.get(url: operation.url, parameters: operation.parameters) { data, error in
                let response = GatewayResponse(json: data, error: error)
                self.responseHandler.handle(gatewayResponse: response,
                                            operation: operation,
                                            completion: completion)
            }
    }
}
