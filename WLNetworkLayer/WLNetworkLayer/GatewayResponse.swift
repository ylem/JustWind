import Foundation

class GatewayResponse {
    
    let data: Data?
    let error: Error?
    
    init(json: Any?, error: Error?) {
        self.error = error
        guard let json = json else { self.data = nil; return }
        self.data = try? JSONSerialization.data(withJSONObject: json,
                                                options: .prettyPrinted)
    }
}
