import Foundation

public enum ServiceClientResponse<T> {
    case success(SuccessfulOperationResponse<T>)
    case failure(ServiceClientError)
}

public struct SuccessfulOperationResponse<T> {
    
    public let object: T
    private let response: OperationResponse
    
    init(object: T,
         response: OperationResponse) {
        self.object = object
        self.response = response
    }
    
    var isWarning: Bool {
        return status != "200"
    }
    
    var status: String {
        return response.status
    }
    
    var messages: String {
        return ""
    }
}
