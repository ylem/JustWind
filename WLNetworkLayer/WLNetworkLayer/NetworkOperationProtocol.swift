import Foundation

public protocol NetworkOperationProtocol {
    
    associatedtype ReturnType
    
    var url: String { get }
    var parameters: [String: Any]? { get }
    
    func parse(_ data: Data) throws -> ReturnType
}

public extension NetworkOperationProtocol where ReturnType == Void {
    
    func parse(_ data: Data) throws {
        return
    }
}
