import Foundation

struct Wind: Decodable {
    
    let speed: Double
    let deg: Double?
    
    enum CodingKeys: String, CodingKey {
        case speed
        case deg
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.speed = try values.decode(Double.self, forKey: .speed)
        
        if values.contains(.deg) {
            self.deg = try values.decode(Double.self, forKey: .deg)
        } else {
            self.deg = nil
        }
    }
}
