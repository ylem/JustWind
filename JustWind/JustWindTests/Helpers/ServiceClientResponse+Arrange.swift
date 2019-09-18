import Foundation

@testable import WLNetworkLayer
@testable import JustWind

extension ServiceClientResponse {
    
    static var arrangeVoidSuccess: ServiceClientResponse<Void> {
        return .arrangeSuccess(())
    }
    
    static func arrangeSuccess<T>(_ object: T) -> ServiceClientResponse<T> {
        let response = OperationResponse(status: "200")
        return .success(SuccessfulOperationResponse(object: object,
                                                    response: response))
    }
    
    static func arrangeFailure<T>(_ error: ServiceClientError) -> ServiceClientResponse<T> {
        return .failure(error)
    }
}
