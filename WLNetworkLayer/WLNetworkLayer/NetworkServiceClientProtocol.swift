import Foundation

public protocol NetworkServiceClientProtocol {
    
    func call<O: NetworkOperationProtocol>(operation: O,
                                           completion: @escaping ServiceClientCompletion<O.ReturnType>)
}

public typealias ServiceClientCompletion<T> = (ServiceClientResponse<T>) -> Void
