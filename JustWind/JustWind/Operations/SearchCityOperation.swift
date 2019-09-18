import Foundation
import WLNetworkLayer

final class SearchCityOperation: NetworkOperationProtocol {
    
    var url: String {
        return "find"
    }
    
    var parameters: [String: Any]? {
        return [
            "q": "\(keyword)"
        ]
    }
    
    private let keyword: String
    
    init(keyword: String) {
        self.keyword = keyword
    }
    
    func parse(_ data: Data) throws -> SearchCityResponse {
        return try JSONDecoder().decode(SearchCityResponse.self,
                                        from: data)
    }
}
