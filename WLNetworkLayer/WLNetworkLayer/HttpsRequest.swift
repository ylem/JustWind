import Foundation

public class HttpsRequest {
    
    private let baseURL: String
    private let session: URLSession
    
    private var dataTask: URLSessionDataTask?
    
    init(baseURL: String, session: URLSession) {
        self.baseURL = baseURL
        self.session = session
    }
    
    func get(url: String,
             parameters: [String: Any]? = nil,
             completion: @escaping (Any?, Error?) -> Void ) {
        dataTask?.cancel()
        
        guard let url = weatherAppURL(urlString: url, parameters: parameters) else { return }
        dataTask = session.dataTask(with: url) { [weak self] data, response, error in
            defer { self?.dataTask = nil }
            
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200
                else {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
            }
            
            DispatchQueue.main.async {
                completion(data, nil)
            }
        }
        dataTask?.resume()
    }
}

public class DefaultHttpsRequest: HttpsRequest {
    
    public override init(baseURL: String = "https://api.openweathermap.org/data/2.5/",
                         session: URLSession = URLSession(configuration: .default)) {
        super.init(baseURL: baseURL, session: session)
    }
}

extension HttpsRequest {
    
    func weatherAppURL(urlString: String, parameters: [String: Any]?) -> URL? {
        guard
            let parameters = parameters,
            var urlComponents = URLComponents(string: (baseURL + urlString))
            else { return URL(string: (baseURL + urlString)) }
        
        urlComponents.query = parameters.reduce(into: "appid=d797525adfb367562531a1ec8f687706", {
            (result, next) in
            result += "&\(next.key)=\(next.value)"
        })
        
        return urlComponents.url
    }
}
