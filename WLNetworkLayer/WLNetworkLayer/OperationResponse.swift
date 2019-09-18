import Foundation

public struct OperationResponse: Codable {
    
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case status = "cod"
    }
}

extension OperationResponse {
    
    var failure: Bool {
        return status != "200"
    }
}
