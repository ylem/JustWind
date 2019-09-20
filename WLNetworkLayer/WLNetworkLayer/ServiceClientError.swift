import Foundation

public enum ServiceClientError: Error {
    case client(Error)
    case service(String)
    case operation(OperationResponse)
    case parse(Error)
    case unknown
}

extension ServiceClientError {
    
    public var title: String {
        switch self {
        case .operation(let response):
            return "\(response.status)"
        default:
            return "Error"
        }
    }
    
    public var message: String {
        switch self {
        case .client(let error), .parse(let error):
            return error.localizedDescription
        case .operation(let response):
            return response.status
        default:
            return "An unknown error has occured"
        }
    }
}
