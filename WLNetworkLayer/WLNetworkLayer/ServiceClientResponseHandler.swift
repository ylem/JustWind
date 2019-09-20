import Foundation

public struct ServiceClientResponseHandler {
    
    private let decoder: JSONDecoder
    
    public init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func handle<O: NetworkOperationProtocol>(gatewayResponse: GatewayResponse,
                                             operation: O,
                                             completion: @escaping ServiceClientCompletion<O.ReturnType>) {
        complete(gatewayResponse: gatewayResponse,
                 operation: operation,
                 completion: completion)
    }
    
    private func complete<O: NetworkOperationProtocol>(gatewayResponse: GatewayResponse,
                                                       operation: O,
                                                       completion: @escaping ServiceClientCompletion<O.ReturnType>) {
        switch (gatewayResponse.data, gatewayResponse.error) {
        case (_, .some(let error)):
            completion(.failure(.client(error)))
        case (.some(let data), _):
            completion(successResponse(operation: operation, data: data))
        default:
            completion(.failure(.unknown))
        }
    }
    
    private func successResponse<O: NetworkOperationProtocol>(operation: O,
                                                              data: Data) -> ServiceClientResponse<O.ReturnType> {
        let response: ServiceClientResponse<O.ReturnType>
        do {
            let object: O.ReturnType = try operation.parse(data)
            
            // have to manually setup a success response status.
            // I am looking for the API can give me a status key/value in all responses
            let success = SuccessfulOperationResponse(object: object,
                                                      response: OperationResponse(status: "200"))
            response = .success(success)
        } catch {
            response = .failure(.parse(error))
        }
        return response
    }
}
