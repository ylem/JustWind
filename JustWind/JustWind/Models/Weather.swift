import Foundation

struct Weather: Decodable {
    
    let id: Int
    let main: String
    let description: String
    let icon: String?
}

extension Weather {
    
    var iconLink: String? {
        guard let icon = icon else { return nil }
        return "http://openweathermap.org/img/wn/\(icon).png"
    }
}
